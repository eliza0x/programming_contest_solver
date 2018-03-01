main :: IO ()
main = do
    y <- read <$> getLine :: IO Int
    putStrLn $ if (mod y 4 == 0 && mod y 100 /= 0) || mod y 400 == 0 then "YES" else "NO"
