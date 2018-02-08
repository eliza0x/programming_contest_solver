import Data.List 

main :: IO ()
main = do
    n <- read <$> getLine
    aa <- scanl (+) 0           . map read . words <$> getLine :: IO [Int]
    ab <- (0:) . reverse . scanl (+) 0 . reverse . map read . words <$> getLine :: IO [Int]

    print . maximum $ map (\i-> aa!!i + ab!!i) [1..n]
