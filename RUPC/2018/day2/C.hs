main :: IO ()
main = do 
    [n, m, c] <- map read . words <$> getLine :: IO [Int]

