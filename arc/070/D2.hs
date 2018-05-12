import qualified Data.Array.Unboxed as U
import Data.Array.Unboxed ((!))
import qualified Data.Array.IO as I
import Control.Monad

main = do
    [n, k] <- map read . words <$> getLine :: IO [Int]
    as <- map read . words <$> getLine :: IO [Int]
    let asa = U.listArray (1, n) as :: U.UArray Int Int
    -- print =<< mapM (dp as n k) [1..n]
    let dropArray = map (\i -> U.listArray (1, n-1) . map fst . filter ((i /=) . fst) . zip [1..] $ as) [1..n] :: [U.UArray Int Int]
    mapM_ print dropArray
    print =<< mapM (\(arr,i) -> dp n k arr i) (zip dropArray [asa!i|i<-[1..n]])

dp :: Int -> Int -> U.UArray Int Int -> Int -> IO Bool
dp n k as s = do
    memo <- I.newArray ((0,0), (k, n-1)) False
    forM_ [0..n-1] $ \i -> I.writeArray memo (0,i) True
    or <$> (forM [(i,j)|i<-[1..k],j<-[1..n-1]] $ \(i,j) -> do
        c  <- boundReadArray memo (i-(as!j), j)
        c' <- boundReadArray memo (i       , j-1)
        I.writeArray memo (i,j) $ c || c'
        return $ k-s <= i && i < k && (c || c'))
    
boundReadArray :: I.IOArray (Int,Int) Bool -> (Int,Int) -> IO Bool
boundReadArray arr (y,x) = do
    ((sy,sx), (ly,lx)) <- I.getBounds arr
    if sy <= y && y <= ly && sx <= x && x <= lx
        then I.readArray arr (x,y)
        else return False
