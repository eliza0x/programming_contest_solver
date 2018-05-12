main :: IO () 
main = do
    [n, a] <- map read . words <$> getLine :: IO [Int]
    xs <- map read . words <$> getLine :: IO [Int]

