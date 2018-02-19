main :: IO ()
main = do
    n <- read <$> getLine :: IO Int
    a <- read <$> getLine :: IO Int
    putStrLn $ if mod n 500 <= a then "Yes" else "No"
