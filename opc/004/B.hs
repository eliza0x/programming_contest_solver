import Data.List
import Control.Monad
import Debug.Trace

main  = do
    n  <- read <$> getLine :: IO Int
    as <- zip [1..] . map read <$> replicateM n getLine :: IO [(Int, Int)]
    print $ makePair as

makePair :: [(Int, Int)] -> Int
makePair []       = 0
makePair [(_, 1)] = 0
makePair ((a, 1):(b, m):l)
    | abs (b-a) <= 1 && m /= 0 = div (m+1) 2 + makePair ([(b, mod (m+1) 2)| mod (m+1) 2 /= 0]++l)
    | otherwise                = makePair ((b, m):l)
makePair ((a, n):l) = (div n 2) + makePair ([(a, mod n 2)| mod n 2 /= 0] ++ l)
