import Prelude hiding (Right, Left)
import Data.List
import Data.Maybe
import qualified Data.IntSet as S

data Dist n = Up | Left | Down | Right deriving Show
data FT     = F Int | T deriving Show

main = do
    s <- concatMap (\x-> if head x == 'F' 
        then [F $ length x] 
        else replicate (length x) T) . group <$> getLine
    [x,y] <- map read . words <$> getLine :: IO [Int]
    putStrLn $ if dpR (S.singleton 0) (S.singleton 0) s (x,y) then "Yes" else "No"

dpR slr sud [] (gx,gy) = S.member gx slr && S.member gy sud
dpR slr sud (x:xs) (gx,gy) = case x of
    F n -> let slr' = S.foldr (\k s -> S.insert (k+n) s) S.empty slr
           in  dpR slr' sud xs (gx,gy)
    T   -> dpUD slr sud xs (gx,gy)

dpLR slr sud [] (gx,gy) = S.member gx slr && S.member gy sud
dpLR slr sud (x:xs) (gx,gy) = case x of
    F n -> let slr' = insertKeys slr n
           in  dpLR slr' sud xs (gx,gy)
    T   -> dpUD slr sud xs (gx,gy)

dpUD slr sud [] (gx,gy) = S.member gx slr && S.member gy sud
dpUD slr sud (x:xs) (gx,gy) = case x of
    F n -> let sud' = insertKeys sud n
           in  dpUD slr sud' xs (gx,gy)
    T   -> dpLR slr sud xs (gx,gy)

insertKeys set n = S.foldr (\k s -> S.insert (k-n) $ S.insert (k+n) s) S.empty set
