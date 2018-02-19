let solve () = 
    let x = Scanf.sscanf (read_line ()) "%d" (fun a -> a) in
    let a = Scanf.sscanf (read_line ()) "%d" (fun a -> a) in
    let b = Scanf.sscanf (read_line ()) "%d" (fun a -> a) 
    in print_int ((x - a) mod b); print_string "\n"

let _ = solve ()
    
(* let x, a, b = Scanf.sscanf (read_line ()) "%d %d" (fun a b -> (a, b)) *)

