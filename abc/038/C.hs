import Data.List

main :: IO ()
main = do
    n <- read <$> getLine :: IO Int
    as <- map read . words <$> getLine :: IO [Int]
    -- (p, q) <-  breakIncreasingNums 0 as ([], [])
    -- print $ breakIncreasingNums 0 as ([], [])
    -- print $ shrincIncreasingSubList as
    print . sum . map (fact . length) $ shrincIncreasingSubList as

fact :: Int -> Int
fact 0 = 0
fact n = n + fact (n-1)

shrincIncreasingSubList :: [Int] -> [[Int]]
shrincIncreasingSubList [] = []
shrincIncreasingSubList ns = let
    (p, q) = breakIncreasingNums 0 ns ([], [])
    in p : shrincIncreasingSubList q

breakIncreasingNums :: Int -> [Int] -> ([Int], [Int]) -> ([Int], [Int]) 
breakIncreasingNums _ [] (p, q) = (reverse p, reverse q)
breakIncreasingNums prev (x:xs) (p, q) = if prev < x 
    then breakIncreasingNums x xs (x:p, q)
    else (reverse p, reverse q++(x:xs))

