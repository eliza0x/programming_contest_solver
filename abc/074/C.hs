main :: IO ()
main = do
    [a, b, c, d, e, f] <- map read . words <$> getLine :: IO [Int]
    
