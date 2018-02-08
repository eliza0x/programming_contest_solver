main :: IO ()
main = do
    n <- read <$> getLine :: IO Double
    as <- map read . words <$> getLine :: IO [Int]
    let avg  = floor $ fromIntegral (sum as) / n + 0.5 
        diff = sum $ map (double . ((-) avg)) as
    print diff

double :: Int -> Int
double n = n * n
