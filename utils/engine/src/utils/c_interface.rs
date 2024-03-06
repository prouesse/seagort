use std::ffi::{CStr, CString};
use std::os::raw::c_char;

pub unsafe fn ruststring_to_cstring(arg: &str) -> *const c_char {
    let c_string = CString::new(arg).expect("CString conversion failed");

    // Get a raw pointer to the underlying bytes
    let c_ptr: *const c_char = c_string.as_ptr();

    println!("C String {:?}", unsafe { CStr::from_ptr(c_ptr) });

    c_string.into_raw()
}

pub unsafe fn cchar_to_ruststr(word: *const c_char) -> String {
    let var = unsafe { CStr::from_ptr(word) };
    let printable = var.to_string_lossy().into_owned();

    println!("Rust String {}", printable);

    printable
}

pub unsafe fn cchar_to_ruststaticstr(word: *const c_char) -> &'static str {
    let var = CStr::from_ptr(word);
    let printable = var.to_string_lossy().into_owned();

    let c_string = CString::new(printable).expect("Failed to convert to CString");
    let static_str = c_string.into_string().expect("Failed to convert to String");

    println!("Rust String {}", static_str);

    Box::leak(static_str.into_boxed_str())
}