main = do
    n <- read <$> getLine :: IO Double
    print $ (9/5*n) + 32
