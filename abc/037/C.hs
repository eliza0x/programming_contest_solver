import qualified Control.Monad as C
import qualified Data.Array.IO as A
import qualified Data.IORef    as R

main :: IO ()
main = do
    [n, k] <- map read . words <$> getLine :: IO [Integer]
    as <- A.newArray (0, n) 0 :: IO (A.IOArray Integer Integer)
    (as, 0) <<- 0
    C.mapM_ (\(i, x)-> (as, i) <<- x) 
        =<< zip [1..] . map read . words <$> getLine
    locallySum <- R.newIORef 0 :: IO (R.IORef Integer)
    sum        <- R.newIORef 0 :: IO (R.IORef Integer)

    C.forM_ [0..k-1] $ \i -> do 
        x <- as ! i
        R.modifyIORef locallySum (+x)

    C.forM_ [k..n] $ \i -> do
        s <- as ! (i-k)
        l <- as ! i
        R.modifyIORef locallySum (\x->x+l-s)
        x <- R.readIORef locallySum
        R.modifyIORef sum (+x)
        {-
        putStr "locallySum: "
        print =<< R.readIORef locallySum
        putStr "sum: "
        print =<< R.readIORef sum
        putStrLn ""
        -}

    print =<< R.readIORef sum

(!) :: (A.Ix x) => A.IOArray x y -> x -> IO y
arr ! n = A.readArray arr n
{-# INLINE (!) #-}
 
(!?) :: (A.Ix x) => A.IOArray x y -> x -> IO (Maybe y)
arr !? n = do
    (start, last) <- A.getBounds arr
    if n >= start && last >= n 
        then Just <$> arr ! n 
        else return Nothing
{-# INLINE (!?) #-}
 
(<<-) :: (A.Ix x) => (A.IOArray x y, x) -> y -> IO ()
(arr, i) <<- v = A.writeArray arr i v
{-# INLINE (<<-) #-}

