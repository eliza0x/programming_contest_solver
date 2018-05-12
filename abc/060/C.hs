import qualified Data.Array as A
import Data.Array ((!))

main = do
    [n, a] <- map read . words <$> getLine :: IO [Int]
    xs     <- map read . words <$> getLine :: IO [Int]
    print . foldr (\b s -> s + (if b then 1 else 0)) 0 $ map (\i -> dp n xs!(n, i)) [0..2500]

dp :: Int -> [Int] -> A.Array (Int, Int) Bool
dp n xs = memo where
    memo = A.array ((0,0),(n,2500)) [((i,j),f i j n)|(i, n)<-zip [0..n] (0:xs), j<-[0..2500]]
    f 0 0 _ = True
    f 0 _ _ = False
    f i j n = (if i-n >= 0 then memo!(i-1, j-n) else False) || memo!(i-1, j)
