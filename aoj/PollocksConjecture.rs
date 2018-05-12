use std::io::{self, BufRead};

fn to_int(str: String) -> i32 {
    str.trim_matches('\n').parse::<i32>().unwrap()
}

fn main() {
    // let mut memo = [0; 10e6 as usize];
    let mut buffer = String::new();
    let stdin = io::stdin();
    let mut handle = stdin.lock();
    let _ = handle.read_line(&mut buffer);
    println!("{}", buffer.split(" ").collect::<Vec<&str>>());
}

