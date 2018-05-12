main :: IO ()
main = do
    n <- read <$> getLine :: IO Int
    print $ 800 * n  - (div n 15 * 200)
