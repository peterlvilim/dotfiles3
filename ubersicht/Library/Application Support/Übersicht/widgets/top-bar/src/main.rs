mod internet;

use chrono_tz::Tz;
use internet::{debounce, have_internet, Internet};
use serde::{Deserialize, Serialize};
use serde_json::Value;
use std::{path::PathBuf, process::Command, time::Duration};

#[derive(Debug, Serialize, Deserialize)]
struct DateGroup {
    month: u32,
    day: u32,
    weekday: String,
    times: Vec<OutputTime>,
}
#[derive(Debug, Serialize, Deserialize)]
struct OutputTime {
    label: String,
    hour: u32,
    minute: u32,
}
use chrono_tz;

use chrono::{Datelike, Timelike, Utc, Weekday};

fn get_date_time(tzs: Vec<(String, Tz)>) -> (DateGroup, DateGroup) {
    let mut group_one = DateGroup {
        month: 0,
        day: 0,
        weekday: Weekday::Mon.to_string(),
        times: vec![],
    };
    let mut group_two = DateGroup {
        month: 0,
        day: 0,
        weekday: Weekday::Mon.to_string(),
        times: vec![],
    };
    for (label, tz) in tzs {
        let now = Utc::now().with_timezone(&tz);
        if group_one.day == 0 {
            group_one.month = now.month();
            group_one.day = now.day();
            group_one.weekday = now.weekday().to_string();
        } else if group_two.day == 0 && now.day() != group_one.day {
            group_two.month = now.month();
            group_two.day = now.day();
            group_two.weekday = now.weekday().to_string();
        }
        if now.day() == group_one.day {
            assert_eq!(now.month(), group_one.month);
            assert_eq!(now.weekday().to_string(), group_one.weekday);
            group_one.times.push(OutputTime {
                label,
                hour: now.hour(),
                minute: now.minute(),
            });
        } else if now.day() == group_two.day {
            assert_eq!(now.month(), group_two.month);
            assert_eq!(now.weekday().to_string(), group_two.weekday);
            group_two.times.push(OutputTime {
                label,
                hour: now.hour(),
                minute: now.minute(),
            });
        } else {
            unreachable!();
        }
    }
    group_one.times.sort_by(|a, b| a.hour.cmp(&b.hour));
    group_two.times.sort_by(|a, b| a.hour.cmp(&b.hour));
    if group_one.day <= group_two.day {
        (group_one, group_two)
    } else {
        (group_two, group_one)
    }
}

#[derive(Serialize, Deserialize)]
struct Output {
    spaces: Vec<Workspace>,
    date_group_1: DateGroup,
    date_group_2: DateGroup,
    internet: Internet,
}

#[derive(Serialize, Deserialize)]
struct Workspace {
    index: u64,
    label: String,
    enabled: bool,
}

fn get_workspaces() -> Vec<Workspace> {
    let mut workspaces = vec![];
    let output = &Command::new("/opt/homebrew/bin/yabai")
        .args(&["-m", "query", "--spaces"])
        .output()
        .expect("failed to execute process")
        .stdout;
    let output = String::from_utf8_lossy(output);
    let data: Value = serde_json::from_str(&output).expect("decode failed");
    for space in data.as_array().unwrap().iter() {
        let index = space.get("index").unwrap().as_u64().unwrap();
        let label = space.get("label").unwrap().as_str().unwrap().to_string();
        let enabled = space.get("is-visible").unwrap().as_bool().unwrap();
        workspaces.push(Workspace { index, label, enabled });
    }
    return workspaces;
}
// debounce?
// json file for struct

fn main() {
    let workspaces = get_workspaces();
    let (date_group_1, date_group_2) = get_date_time(vec![
        (String::from("SFO"), chrono_tz::US::Pacific),
        (String::from("UTC"), chrono_tz::UTC),
        (String::from("SIN"), chrono_tz::Asia::Singapore),
        (String::from("PAR"), chrono_tz::Europe::Paris),
        (String::from("ICN"), chrono_tz::Asia::Seoul),
    ]);
    debounce(PathBuf::from("check_internet.json"), Duration::from_secs(10), || {
        serde_json::to_string(&have_internet()).unwrap()
    });
    let output = Output {
        spaces: workspaces,
        date_group_1,
        date_group_2,
        internet: Internet { connected: true },
    };
    println!("{}", serde_json::to_string(&output).unwrap())
}
