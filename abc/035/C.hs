import qualified Data.Array.IO as A
import qualified Control.Monad as C
import qualified Data.IORef    as R

main :: IO ()
main = do
    [n, q] <- map read . words <$> getLine :: IO [Int]
    board <- A.newArray (1, n+1) 0 :: IO (A.IOArray Int Int)
    C.replicateM_ q $ do
        [l, r] <- map read . words <$> getLine :: IO [Int]
        nowL <- board ! l
        nowR <- board ! (r+1)
        (board, l)   <<- (nowL+1)
        (board, r+1) <<- (nowR-1)

    {-
    state <- R.newIORef 0 :: IO (R.IORef Int)
    C.forM_ [1..n] $ \i -> do
        bit      <- board ! i :: IO Int
        newState <- (+ bit) <$> R.readIORef state 
        R.writeIORef state newState
        putChar $ if mod newState 2 == 0 then '0' else '1'
    putStrLn ""
    -}

    putStrLn =<< put board 0 1 (n+1)

put :: A.IOArray Int Int -> Int -> Int -> Int -> IO String
put imos state index upper = if index == upper 
    then return "" else do
        state' <- (state +) <$> (imos ! index) :: IO Int
        ((if mod state' 2 == 0 then '0' else '1'):) <$> put imos state' (index+1) upper
        
    

(!) :: (A.Ix x) => A.IOArray x y -> x -> IO y
arr ! n = A.readArray arr n
{-# INLINE (!) #-}
 
(!?) :: (A.Ix x) => A.IOArray x y -> x -> IO (Maybe y)
arr !? n = do
    (start, last) <- A.getBounds arr
    if n >= start && last >= n 
        then Just <$> A.readArray arr n 
        else return Nothing
{-# INLINE (!?) #-}
 
(<<-) :: (A.Ix x) => (A.IOArray x y, x) -> y -> IO ()
(arr, i) <<- v = A.writeArray arr i v
{-# INLINE (<<-) #-}
 
