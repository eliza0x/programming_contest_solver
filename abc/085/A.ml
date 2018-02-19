let solve () =
    let y, s = Scanf.sscanf 
        (read_line ()) "%d/%s" (fun y s -> (y, s))
    in print_string "2018/";print_string s;print_string "\n"

let _ = solve ()
