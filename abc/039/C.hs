import Data.List

main :: IO ()
main = do
    let board = concat $ repeat "WBWBWWBWBWBW"
    input <- getLine :: IO String
    putStrLn $ case match board input 0 of
        0  -> "Do"
        1  -> "Do"
        2  -> "Re"
        3  -> "Re"
        4  -> "Mi"
        5  -> "Fa"
        6  -> "Fa"
        7  -> "So"
        8  -> "So"
        9  -> "La"
        10 -> "La"
        11 -> "Si"

match :: String -> String -> Int -> Int
match str str' cnt = if match' str str'
    then cnt
    else match (tail str) str' (cnt+1)
    where
    match' :: String -> String -> Bool
    match' [] _ = True
    match' _ [] = True
    match' (s:str) (s':str') = (s == s') && match' str str'
    
