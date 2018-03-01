main = do
    [x, y, z] <- map read . words <$> getLine :: IO [Int]
    print . minimum $ [x+y, x+z, y+z]
