import Data.Array.Unboxed ((!))
import qualified Data.Array.Unboxed as U
import qualified Data.Array.IO as A
import Control.Monad
import Data.Maybe
import Data.List
import Data.Bool

main :: IO ()
main = do
    [a, b] <- map read . words <$> getLine :: IO [Int]
    as <- U.listArray (1, a) . map read . words <$> getLine :: IO (U.UArray Int Int)
    bs <- U.listArray (1, b) . map read . words <$> getLine :: IO (U.UArray Int Int)
    t <- dp as bs a b

    forM_ [(i,j)|i<-[0..a], j<-[0..b]] $ \(i,j) -> do
        c <- A.readArray t (i,j)
        putStr $ replicate (3 - (length . show $ c)) ' '
        putStr . show $ c
        when (j == b) $ putStrLn ""

    print =<< A.readArray t (a,b)

dp :: U.UArray Int Int -> U.UArray Int Int -> Int -> Int -> IO (A.IOArray (Int, Int) Int)
dp as bs a b = do
    memo <- A.newArray ((0,0), (a,b)) 0 :: IO (A.IOArray (Int,Int) Int)

    forM_ [1..a] $ \i -> do
        c  <- A.readArray memo (i-1, 0)
        A.writeArray memo (i,0) $ if mod (a+b-i) 2 == 0 then c+as!(a-(i-1)) else c
    
    forM_ [1..b] $ \j -> do
        c' <- A.readArray memo (0, j-1)
        A.writeArray memo (0,j) $ if mod (a+b-j) 2 == 0 then c'+bs!(b-(j-1)) else c'
 
    forM_ [(i,j)|i<- [1..a], j<- [1..b]] $ \(i,j) -> do
        c  <- A.readArray memo (i, j-1)
        c' <- A.readArray memo (i-1, j)
        A.writeArray memo (i,j) $ if mod (a+b-(i+j)) 2 == 0 then max (c+as!(a-(i-1))) (c'+bs!(b-(j-1))) else min c c'
    return memo

