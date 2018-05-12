import qualified Data.ByteString.Char8 as BC
import           Data.Maybe            (fromJust)
import           Data.Vector           ((!))
import qualified Data.Vector           as V
 
main :: IO ()
main = do
  [a, b] <- readInts
  as <- readInts
  bs <- readInts
  print $ solve a b as bs
 
readInts :: IO [Int]
readInts = map (fst . fromJust . BC.readInt) . BC.words <$> BC.getLine
 
solve :: Int -> Int -> [Int] -> [Int] -> Int
solve a b as bs = arr ! a ! b where
  asArr = V.fromList as
  bsArr = V.fromList bs
  isFirst i j = (a + b - (i + j)) `mod` 2 == 0
  arr = V.fromList [V.fromList [dp i j | j <- [0 .. b]] | i <- [0 .. a]]
  dp 0 0 = 0
  dp i 0
    | isFirst i 0 = arr ! (i - 1) ! 0 + asArr ! (a - i)
    | otherwise   = arr ! (i - 1) ! 0
  dp 0 j
    | isFirst 0 j = arr ! 0 ! (j - 1) + bsArr ! (b - j)
    | otherwise   = arr ! 0 ! (j - 1)
  dp i j
    | isFirst i j = max (arr ! (i - 1) ! j + asArr ! (a - i)) (arr ! i ! (j - 1) + bsArr ! (b - j))
    | otherwise   = min (arr ! (i - 1) ! j) (arr ! i ! (j - 1))
