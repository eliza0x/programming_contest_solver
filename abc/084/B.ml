let solve () = 
    let a, b = Scanf.scanf "%d %d" (fun a b -> a, b)
    in let s = read_line ()
    in let len   = a+b+1 == String.length s
    in let rec valid i = 
        match (i < a, i = a, i < (a+b+1)) with
        | (true, false, false) -> String.get s i <> '-' && valid (i+1) 
        | (_, true, false)     -> String.get s i =  '-' && valid (i+1) 
        | (_, _, true)         -> String.get s i <> '-' && valid (i+1) 
        | (_, _, _)            -> true
    in if len && valid 0 then "Yes" else "No"

let _ = print_string (solve ()); print_newline ()

