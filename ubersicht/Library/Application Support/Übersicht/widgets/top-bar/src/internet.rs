use std::path::PathBuf;

use reqwest::StatusCode;
use serde::{Deserialize, Serialize};

#[derive(Serialize, Deserialize)]
pub struct Internet {
    pub connected: bool,
}

#[derive(Serialize, Deserialize)]
pub struct DebouncedOutput {
    last_check_secs: u64,
    output: String,
}

pub fn debounce<F>(file: PathBuf, period: std::time::Duration, function: F) -> String
where
    F: Fn() -> String,
{
    // background thread
    String::from("")
    // check file size, parse struct, check time if enough, write new output, return struct
    //
}

pub fn have_internet() -> Internet {
    match reqwest::blocking::get("https://www.google.com") {
        Ok(result) => {
            if result.status() == StatusCode::OK {
                Internet { connected: true }
            } else {
                Internet { connected: false }
            }
        },
        Err(_) => Internet { connected: false },
    }
}
