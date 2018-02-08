main :: IO ()
main = do
    [n, m] <- map read . words <$> getLine :: IO [Int]
    putStrLn $ if odd $ n * m then "Odd" else "Even"

