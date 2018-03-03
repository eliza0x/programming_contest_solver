main = do
    [a,b,x] <- map read . words <$> getLine :: IO [Int]
    print $ if a /= b
        then div b x - div (a-1) x
        else if mod a x == 0 then 1 else 0
