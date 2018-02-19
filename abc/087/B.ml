let cnt = ref 0

let solve () = 
    let a = Scanf.sscanf (read_line ()) "%d" (fun a -> a) in
    let b = Scanf.sscanf (read_line ()) "%d" (fun a -> a) in
    let c = Scanf.sscanf (read_line ()) "%d" (fun a -> a) in
    let x = Scanf.sscanf (read_line ()) "%d" (fun a -> a) in
    for i = 0 to a do
        for l = 0 to b do
            for k = 0 to c do
                if i*500+l*100+k*50 == x 
                    then cnt := !cnt + 1
                    else ()
            done
        done
    done

let _ = solve (); print_int (!cnt); print_string "\n"
