import qualified Data.Array.IO as A
import Data.Array.IO
import Control.Monad
import Data.Maybe

type Array = IOArray Int

main :: IO ()
main = do
    n <- read <$> getLine :: IO Int
    ts <- A.newListArray (1,n-1) =<<
        replicateM (n-1) ((\[c,s,f]->(c,s,f)) . map read . words <$> getLine) :: IO (Array (Int, Int, Int))
    forM_ [1..n] $ \i -> do
        print =<< sim ts i 0 n

sim :: Array (Int, Int, Int) 
    -> Int -- current point
    -> Int -- time
    -> Int -- gool
    -> IO Int
sim arr pos time goal = do
    (c, s, f) <- fromMaybe (0, 0, 0) <$> (arr!?pos)
    case (pos==goal, s<=time, mod time f) of
        (True, _, _) -> return time
        (_, True, 0) -> sim arr (pos+1) (time+c) goal 
        (_, True, n) -> sim arr (pos+1) (time+(f-n)+c) goal 
        (_, False,_) -> sim arr (pos+1) (s+c) goal

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
