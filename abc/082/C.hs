import Data.List

main :: IO ()
main = do
    n  <- read <$> getLine :: IO Int
    print . foldr (\(n,l)->if l>=n then (+(l-n)) else (+l)) 0 . map (\l->(head l, length l)) . group . sort . map read . words =<< getLine

