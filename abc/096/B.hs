import Data.List

main = do
    [a, b, c] <- sort . map read . words <$> getLine :: IO [Int]
    k <- read <$> getLine :: IO Int
    print $ a + b + c * pow 2 k

pow n 0 = 1
pow n k = n * pow n (k-1)    
