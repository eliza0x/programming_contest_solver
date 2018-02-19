import Data.List
import Data.Array.IO
import Control.Monad
import qualified Data.Array.IO as A

type Array = IOUArray Int

main :: IO () 
main = do
    n  <- read <$> getLine 
    as <- newListArray (1, n) . sort . map read . words =<< getLine  :: IO (Array Int)
    bs <- newListArray (1, n) . sort . map read . words =<< getLine  :: IO (Array Int)
    cs <- newListArray (1, n) . sort . map read . words =<< getLine :: IO (Array Int)

    ns <- forM [1..n] $ \i -> do
        x <- bs ! i
        ax <- lowerBound as x
        cx <- upperBound cs x
        -- putStrLn $ show (ax, cx) ++ ": " ++ show (ax*(n-cx))
        return $ ax * (n-cx)

    print $ sum ns

upperBound :: Array Int -> Int -> IO Int
upperBound arr n = do
    (s, l) <- getBounds arr
    sc <- arr ! s
    lc <- arr ! l
    case (sc > n, lc < n) of
        (True, _) -> return $ s-1
        (_, True) -> return l
        (_,    _) -> lowerBound' arr (n+1) (s, l)

lowerBound :: Array Int -> Int -> IO Int
lowerBound arr n = do
    (s, l) <- getBounds arr
    sc <- arr ! s
    lc <- arr ! l
    case (sc >= n, lc < n) of
        (True, _) -> return $ s-1
        (_, True) -> return l
        (_,    _) -> lowerBound' arr n (s, l)

lowerBound' :: Array Int -> Int -> (Int, Int) -> IO Int
lowerBound' arr n (s, l) = do
    let a = div (s+l) 2
    x <- arr ! a
    case (x==n, x>n) of
        (True, _) -> return $ a-1
        (_, True) -> if a==l && l-s==1 then return a else lowerBound' arr n (s, a)
        (_,False) -> if a==s && l-s==1 then return a else lowerBound' arr n (a, l)

-- (!) :: (A.Ix x) => IOUArray x y -> x -> IO y
arr ! n = A.readArray arr n
{-# INLINE (!) #-}
 
-- (!?) :: (A.Ix x) => IOUArray x y -> x -> IO (Maybe y)
arr !? n = do
    (start, last) <- getBounds arr
    if n >= start && last >= n 
        then Just <$> A.readArray arr n 
        else return Nothing
{-# INLINE (!?) #-}
 
-- (<<-) :: (A.Ix x) => (IOUArray x y, x) -> y -> IO ()
(arr, i) <<- v = A.writeArray arr i v
{-# INLINE (<<-) #-}
 
