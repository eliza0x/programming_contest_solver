main :: IO ()
main = do
    n <- sum . map (\x-> if x=='o' then 100 else 0) <$> getLine :: IO Int
    print $ n + 700

