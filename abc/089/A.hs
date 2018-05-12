main = do
    n <- read <$> getLine  :: IO Int
    print $ div n 3
