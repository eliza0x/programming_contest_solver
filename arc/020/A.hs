main = do
    [a, b] <- map read . words <$> getLine :: IO [Int]
    putStrLn $ solve (abs a) (abs b)

solve a b
    | a <  b = "Ant"
    | a >  b = "Bug"
    | a == b = "Draw"
