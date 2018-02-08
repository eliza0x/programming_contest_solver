import qualified Data.Array.IO as A
import qualified Control.Monad as C
import Data.List
import Data.Maybe

inf = 1000000000

main :: IO ()
main = do
    n  <- read <$> getLine :: IO Int
    as <- A.newArray (1, n) 0 :: IO (A.IOArray Int Int)
    mapM_ (\(i, x) -> (as, i) <<- read x) . zip [1..n] . words =<< getLine
    dp <- A.newArray (1, n) inf :: IO (A.IOArray Int Int)

    (dp, n) <<- 0
    C.forM_ (reverse [1..n-1]) (\i -> do
        currentHeight <- as ! i
        prevHeight    <- fromMaybe <$> as ! i <*> as !? (i+1)
        prevHeight'   <- fromMaybe <$> as ! i <*> as !? (i+2)
        prevDp        <- fromMaybe inf <$> dp !? (i+1)
        prevDp'       <- fromMaybe inf <$> dp !? (i+2)
        A.writeArray dp i $ min ((abs $ currentHeight - prevHeight)  + prevDp)                                           ((abs $ currentHeight - prevHeight') + prevDp')) 

    {-
    C.forM_ (reverse [1..n]) (\i -> do
        print =<< dp!i)
    -}

    print =<< dp!1

minM :: Maybe Int -> Maybe Int -> Int
minM Nothing Nothing   = 10^9
minM (Just n) Nothing  = n
minM Nothing (Just n)  = n
minM (Just n) (Just m) = min n m


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
 
