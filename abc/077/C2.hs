import Data.Array.Unboxed
import Data.List
import Data.Maybe

import qualified  Data.ByteString.Char8 as BC8

main :: IO ()
main = do
    n  <- read <$> getLine :: IO Int
    as <- listArray (0,n-1) . sort . map (fst . fromJust . BC8.readInt) . BC8.words <$> BC8.getLine :: IO (UArray Int Int)
    bs <- map (fst . fromJust . BC8.readInt) . BC8.words <$> BC8.getLine :: IO [Int]
    cs <- listArray (0,n-1) . sort . map (fst . fromJust . BC8.readInt) . BC8.words <$> BC8.getLine :: IO (UArray Int Int)
    let sm = foldr (\x s -> s + (lowerBound as x * (n - upperBound cs x))) 0 bs
    print $ sm

lowerBound' :: UArray Int Int
            -> (Int, Int)
            -> Int
            -> Int
lowerBound' arr (first, last) n =
    let mid = div (first+last) 2
    in if last - first <= 1
        then if (arr!first) < n then last else first
        else if (arr!mid) < n
            then lowerBound' arr (mid, last)  n
            else lowerBound' arr (first, mid) n

lowerBound :: UArray Int Int -> Int -> Int
lowerBound arr n = let
    (start, last) = bounds arr
    in if (arr!last) < n then last+1
              else lowerBound' arr (start, last) n

upperBound :: UArray Int Int -> Int -> Int
upperBound arr n = lowerBound arr (n+1)

