main :: IO ()
main = do
    n <- read <$> getLine :: IO Int
    print $ (if mod n 10 >= 7 then 100 else mod n 10 * 15) + div n 10 * 100
