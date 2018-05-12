import Data.List
import Control.Monad

main :: IO ()
main = do
    [n, x] <- map read . words <$> getLine :: IO [Int]
    d <- sort <$> replicateM n (read <$> getLine)
    let (gram, n) = foldr (\d (s, n) -> if s+d <= x then (s+d, n+1) else (s, n)) (0,0) d
    print $ n + div (x-gram) (head d)
