main = putStrLn . map (\x-> case x of
    'O' -> '0'
    'D' -> '0'
    'I' -> '1'
    'Z' -> '2'
    'S' -> '5'
    'B' -> '8'
    c   -> c
    ) =<< getLine
