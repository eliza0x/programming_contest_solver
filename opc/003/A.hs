main = do
    [b,a] <- map read . words <$> getLine :: IO [Int]
    print $ div a b + (if mod a b == 0 then 0 else 1)
