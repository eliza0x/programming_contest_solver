import Data.List

main :: IO ()
main = do
    _ <- getLine :: IO String
    as <- map read . words <$> getLine :: IO [Int]
    print . (\(a,b) -> a-b) $ sim (reverse . sort $ as) 0 0

sim :: [Int] -> Int -> Int -> (Int, Int)
sim [] a b = (a, b)
sim (x:xs) a b = sim' xs (a+x) b

sim' :: [Int] -> Int -> Int -> (Int, Int)
sim' [] a b = (a, b)
sim' (x:xs) a b = sim xs a (b+x)
