import qualified Data.Array.IO as A
import qualified Data.IORef as R
import qualified Data.Set as S
import Control.Monad
import Data.List
 
type Array = A.IOArray Int

main :: IO ()
main = do
    [r, c, k] <- map read . words <$> getLine :: IO [Int]
    n <- read <$> getLine :: IO Int
    pos <- replicateM n ((\l-> (l!!0, l!!1)) . map read . words <$> getLine) :: IO [(Int, Int)]
    
    room <- A.newListArray (1, r) =<< 
        replicateM r (A.newArray (1, c) 0) :: IO (Array (Array Int))
    row  <- A.newArray (1, r) 0 :: IO (Array Int)
    col  <- A.newArray (1, c) 0 :: IO (Array Int)
 
    forM_ pos $ \(x, y) -> do
        row' <- row!x
        col' <- col!y
        room' <- room!x
        (row, x)   <<- (row' + 1)
        (col, y)   <<- (col' + 1)
        (room', y) <<- 1
    
    candyRow <- A.newArray (0, n) 0 :: IO (Array Int)
    candyCol <- A.newArray (0, n) 0 :: IO (Array Int)
        
    forM_ [1..min r n] $ \i -> do
        row' <- row!i
        c'   <- candyRow!row'
        (candyRow, row') <<- (c' + 1)

    forM_ [1..min c n] $ \i -> do
        col' <- col!i
        c'   <- candyCol!col'
        (candyCol, col') <<- (c' + 1)
    
    cnt <- R.newIORef 0

    putStrLn "candyRow"
    forM_ [0..n] $ \i ->
        putStr . (++" ") . show =<< (candyRow!i)
    putStrLn ""

    putStrLn "candyCol"
    forM_ [0..n] $ \i -> do
        putStr . (++" ") . show =<< (candyCol!i)
    putStrLn ""


    forM_ [0..k] $ \i -> do
        let si = k - i

        putStrLn ""
        putStr "i: "
        print i
        putStr "si: "
        print si

        c <- candyCol!i
        r <- candyRow!si
        R.modifyIORef cnt (+ (c+r))

    print =<< R.readIORef cnt

    return ()

(!) :: (A.Ix x) => A.IOArray x y -> x -> IO y
arr ! n = A.readArray arr n
{-# INLINE (!) #-}
 
(!?) :: (A.Ix x) => A.IOArray x y -> x -> IO (Maybe y)
arr !? n = do
    (start, last') <- A.getBounds arr
    if n >= start && last' >= n 
        then Just <$> A.readArray arr n 
        else return Nothing
{-# INLINE (!?) #-}
 
(<<-) :: (A.Ix x) => (A.IOArray x y, x) -> y -> IO ()
(arr, i) <<- v = A.writeArray arr i v
{-# INLINE (<<-) #-}

