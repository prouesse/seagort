use std::os::raw::c_char;
use deno_core::serde_json;
use deno_core::serde_v8;
use deno_core::v8;
use deno_core::JsRuntime;
use deno_core::RuntimeOptions;

mod utils {
    pub mod c_interface;
}

pub fn eval(
    context: &mut JsRuntime,
    code: &'static str,
) -> Result<serde_json::Value, String> {
    let res = context.execute_script("<anon>", deno_core::ModuleCodeString::from_static(code));
    match res {
      Ok(global) => {
        let scope = &mut context.handle_scope();
        let local = v8::Local::new(scope, global);
        // Deserialize a `v8` object into a Rust type using `serde_v8`,
        // in this case deserialize to a JSON `Value`.
        let deserialized_value =
          serde_v8::from_v8::<serde_json::Value>(scope, local);
  
        match deserialized_value {
          Ok(value) => Ok(value),
          Err(err) => Err(format!("Cannot deserialize value: {err:?}")),
        }
      }
      Err(err) => Err(format!("Evaling error: {err:?}")),
    }
  }

pub fn run_js(code: *const c_char) {
    let mut runtime = JsRuntime::new(RuntimeOptions {
        ..Default::default()
    });

    let bor_rcode = unsafe { utils::c_interface::cchar_to_ruststaticstr(code) };
    // Now we see how to invoke the op we just defined. The runtime automatically
    // contains a Deno.core object with several functions for interacting with it.
    // You can find its definition in core.js.
    runtime
    .execute_script(
        "<usage>",
        deno_core::ModuleCodeString::from_static(&bor_rcode),
    )
    .unwrap();
}

fn run_js_with_result(code: *const c_char) -> String {
    let mut runtime = JsRuntime::new(RuntimeOptions {
        ..Default::default()
    });

    let rcode = unsafe { utils::c_interface::cchar_to_ruststaticstr(code) };

    let output: serde_json::Value = eval(&mut runtime, rcode).expect("Eval failed");

    output.to_string()
}

#[no_mangle]
pub extern "C" fn compile_js(code: *const c_char) -> *const c_char {
    unsafe {
        utils::c_interface::ruststring_to_cstring(&run_js_with_result(code))
    }
}