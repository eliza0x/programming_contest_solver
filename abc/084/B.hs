import Data.List

main = do
    [a, b] <- map read . words <$> getLine :: IO [Int]
    s <- getLine :: IO String
    putStrLn $ if length s == (a+b+1) 
             && all (\c -> c /= '-') (take a s)
             && (s!!a) == '-'
             && all (\c -> c /= '-') (drop (a+1) s) 
        then "Yes" else "No"
