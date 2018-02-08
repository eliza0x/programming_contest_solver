import Data.List

main :: IO ()
main = do
    [n, y] <- map read . words <$> getLine :: IO [Int]

    let l = concatMap (\(a,b)->if y == 10000*(n-a)+5000*(a-b)+1000*b then [(n-a, a-b, b)] else [])
                [(a, b)|a <- [0..n], b <- [0..n], n-a>=0, a-b>=0, (n-a)+(a-b)+b <= n] 
    
    putStrLn $ ans l
    where
    ans [] = "-1 -1 -1"
    ans ((a,b,c):_) = show a++" "++show b++" "++show c

