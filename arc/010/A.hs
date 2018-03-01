import Data.Maybe
import Control.Monad

main :: IO ()
main = do
    [n, m, a, b] <- map read . words <$> getLine :: IO [Int]
    cs <- replicateM m (read <$> getLine) :: IO [Int]

    let s = sim cs 0 n a b
    putStrLn $ if not (isJust s) then "complete" else show (fromJust s)

sim [] _ _ _ _ = Nothing
sim (c:cs) d n a b = let
    n' = if n <= a then n+b else n
    in if n' - c >= 0
    then sim cs (d+1) (n' - c) a b
    else Just (d+1)
