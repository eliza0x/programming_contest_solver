main = do
    [n, m] <- map read . words <$> getLine :: IO [Int]
    print . head $ filter (/=m) [1..n]
