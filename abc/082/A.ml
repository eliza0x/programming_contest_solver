let solve () =
    let a, b = Scanf.scanf "%d %d" (fun a b -> a, b)
    in (float_of_int a +. float_of_int b) /. 2.0 +. 0.999999999
    |> int_of_float
    |> print_int
    |> print_newline

let _ = solve ()
