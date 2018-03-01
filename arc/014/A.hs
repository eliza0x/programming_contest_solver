main = do
    n <- read <$> getLine :: IO Int
    putStrLn $ if odd n then "Red" else "Blue"
