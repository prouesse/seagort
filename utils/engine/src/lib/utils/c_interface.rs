use std::ffi::{CStr, CString};
use std::os::raw::c_char;

pub unsafe fn ruststring_to_cstring(arg: &str) -> *const c_char {
    let c_string = CString::new(arg).expect("CString conversion failed");

    c_string.into_raw()
}

pub unsafe fn cchar_to_ruststaticstr(word: *const c_char) -> &'static str {
    let var = CStr::from_ptr(word);
    let printable = var.to_string_lossy().into_owned();

    let c_string = CString::new(printable).expect("Failed to convert to CString");
    let static_str = c_string.into_string().expect("Failed to convert to String");

    Box::leak(static_str.into_boxed_str())
}