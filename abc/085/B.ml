let input () =
    let n  = int_of_string (read_line ())
    in let rec ds i result = if i >= n
        then result
        else let input = int_of_string (read_line ())
             in  ds (i+1) (input::result)
    in List.rev (ds 0 [])

let remove_duplicate (x::xs) = 
    let rec remove_duplicate' prev l = 
        match l with
        | []    -> []
        | x::xs -> if x == prev 
            then remove_duplicate' x xs
            else x :: (remove_duplicate' x xs)
    in x :: (remove_duplicate' x xs)

let _ = List.sort (Pervasives.compare) (input ())
     |> remove_duplicate
     |> List.length 
     |> print_int 
     |> print_newline
