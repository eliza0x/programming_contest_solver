import qualified Data.ByteString.Char8 as BC8
import Data.Maybe
import Control.Monad
import Data.List
import qualified Data.Array.Unboxed as U
import Data.Array ((!))

main :: IO ()
main = do
    [n, c] <- map read . words <$> getLine :: IO [Int]
    ns <- sort <$> replicateM n ((\[a,b]->(a,b)) . map (fst . fromJust . BC8.readInt) . BC8.words <$> BC8.getLine)
    let sum  = scanl (\(p,c) (p',c') -> (p+p', c+c')) (0,0) ns
    let rsum = scanl (\(p,c) (p',c') -> (p+p', c+c')) (0,0) (reverse ns)

    let sumD  = foldr (\i -> if i < (n-i) then toAA n c sum ! i + toA n c rsum ! i else 0) (0, 0) [1..n]
    let rsumD = foldr (\i -> if i < (n-i) then toAA n c rsum ! i + toA n c sum ! i else 0) (0, 0) [1..n]

    print $ max [maximum $ map c sum, maximum $ map c rsum, maximum sumD, maximum rsumD]

toA :: Int -> Int -> [a] -> U.Array Int a
toA n c l  = U.listArray (1,n) . map c
toAA :: Int -> Int -> [a] -> U.Array Int a
toAA n c l = toA n c $ foldr (\(p,c) (p',c') -> max (c-p*2) (c'-p'*2)) (0, 0) [1..n]
c p = fst p - snd p
