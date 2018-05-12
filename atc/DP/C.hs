main :: IO ()
main = do
    k  <- read <$> getLine :: IO Int
    rs <- zip [1..] . map read . words <$> getLine :: IO [(Int,Int)]

