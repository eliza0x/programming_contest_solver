import Data.Bool
import Data.List
import Data.Maybe
import Data.Bits
import Debug.Trace
import Control.Monad
import qualified Data.Array.IO as A
import qualified Data.Array.Unboxed as U
import Data.Array.Unboxed ((!))

main = do
    [n, k] <- map read . words <$> getLine :: IO [Int]
    as <- U.listArray (1,n) . sort . map read . words <$> getLine :: IO (U.UArray Int Int)
    print as
    print =<< mapM (dp as n k) [1..n]

dp :: U.UArray Int Int -> Int -> Int -> Int -> IO Bool
dp as n k divide = do
    memo <- A.newArray ((0, 0), (k, n)) False :: IO (A.IOUArray (Int, Int) Bool)
    forM_ [(i,j)|i<-[0], j<-[0..n], i/=divide] $ \(i,j) -> do
        A.writeArray memo (0, j) True
    or <$> (forM [(i,j)|i<-[1..k], j<-[1..n]] $ \(i,j) -> do
        c  <- if j == divide then return False 
                             else fromMaybe False <$> boundReadArray memo (i-as!j, j)
        c' <- fromMaybe False <$> boundReadArray memo (i, j-1)
        A.writeArray memo (i,j) $ c || c'
        return $ if k-(as!divide) <= i && i < k then c || c' else False)

boundReadArray arr (y,x) = do
    ((sy,sx),(ly,lx)) <- A.getBounds arr
    if sy <= y && y <= ly && sx <= x && x <= lx 
        then Just <$> A.readArray arr (y,x) 
        else return Nothing
        

popBits i n = [mask+1|mask<-[0..n-1], testBit i mask]

