import qualified Data.Array.IO as A
import qualified Control.Monad as C
import qualified Data.List as L
import qualified Data.Maybe as M

data Obj = Obj {
    getWeight :: Int,
    getValue  :: Int,
    getColor  :: Int
    } deriving (Show, Eq)

main :: IO ()
main = do
    [n, w, c] <- map read . words <$> getLine :: IO [Int]
    obj_by_colors <- newArray (1, c) [] :: IO (IOArray Int [Obj])
    C.forM_ [1..n] (\n -> do
        [w, v, c] <- map read . words <$> getLine :: IO [Int]
        obj_by_colors
        return $ Obj w v c)
    
    print objs

minM :: (Ord x) => Maybe x -> Maybe x -> Maybe x
minM Nothing Nothing  = Nothing
minM Nothing (Just x) = Just x
minM (Just x) Nothing = Just x
minM x y = min <$> x <*> y

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

