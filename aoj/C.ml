open Scanf
open Printf
 
let input_array n = Array.init n (fun _ -> scanf "%d " (fun x -> x))
let n  = scanf "%d\n" (fun x -> x)
let s_ = input_array n
let q  = scanf "%d\n" (fun x -> x)
let t_ = input_array q

let rec lower_bound' arr (first, last) n =
    let mid = (first+last)/2
    in if last - first = 1
        then if (arr.(first) < n) then last else first
        else if (arr.(mid) < n) 
            then lower_bound' arr (mid, last)  n
            else lower_bound' arr (first, mid) n


let lower_bound arr n = if arr.(Array.length arr - 1) < n
    then Array.length arr
    else lower_bound' arr (0, Array.length arr - 1) n

let upper_bound arr n = lower_bound' arr (0, Array.length arr - 1) (n+1)

let _ = Array.sort Pervasives.compare s_; t_
    |> Array.map (fun x -> lower_bound s_ x)
    |> Array.map (fun x -> print_int x; print_string " ")
    ; print_newline ()

