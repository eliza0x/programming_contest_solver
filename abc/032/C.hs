import qualified Data.Array.IO as A
import Data.IORef
import Control.Monad 
import Debug.Trace

main :: IO ()
main = do
    [n, k] <- map read . words <$> getLine :: IO [Int]
    ss <- A.newArray (1, n) 0 :: IO (A.IOArray Int Int)
    input <- getContents
    forM_ (zip [1..] . map read . lines $ input)
        $ \(i, x) -> (ss, i) <<- x

    -- forM_ [1..n] $ \i -> print =<< (ss!i)    
    
    is_elem <- findElem ss 0 1 n
    if is_elem then print n
        else print . maximum =<< countSubLists ss 0 1 1 1 n k

countSubLists :: A.IOArray Int Int
              -> Int
              -> Int
              -> Int
              -> Int
              -> Int
              -> Int
              -> IO [Int]
countSubLists arr cnt mul start last n k = if n <= last
        then do
            return $ if mul <= k then [0] else [cnt]
        else do
        mul' <- if start == last then arr ! start else (mul *) <$> (arr ! last)
        case (mul' <= k, start == last) of
            (True, _)      -> countSubLists arr (cnt+1) mul' start (last+1) n k
            (False, False) -> do
                mul'' <- div mul' <$> (arr ! start)
                (cnt:) <$> countSubLists arr (cnt-1) mul'' (start+1) last n k
            (False, True)  -> do
                mul'' <- arr ! start
                (cnt:) <$> countSubLists arr 0 mul'' (start+1) (last+1) n k

mularr :: A.IOArray Int Int
       -> Int
       -> Int
       -> IO Int
mularr arr start last = do
    sum <- newIORef 1 :: IO (IORef Int)
    forM_ [start..last] $ \i -> 
        modifyIORef sum (*i)
    readIORef sum

findElem :: A.IOArray Int Int -> Int -> Int -> Int -> IO Bool
findElem arr n start last = do
    sum <- newIORef False :: IO (IORef Bool)
    forM_ [start..last] $ \i -> do
        f <- (== n) <$> (arr ! i) 
        modifyIORef sum (|| f)
    readIORef sum

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
 
