import Data.List
import Control.Monad

main :: IO ()
main = do
    [a, b, x] <- map read . words <$> getLine :: IO [Int]
    putStrLn $ if a <= x && x <= a+b then "YES" else "NO"
