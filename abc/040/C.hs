import qualified Data.Array.IO as A
import qualified Control.Monad as C
import qualified Data.List as L
import qualified Data.Maybe as M

main :: IO ()
main = do
    n <- read <$> getLine
    dp <- A.newArray (1,n) Nothing :: IO (A.IOArray Int (Maybe Int))
    (dp, n) <<- Just 0
    polls <- A.newArray (1,n) 0 :: IO (A.IOArray Int Int)
    C.zipWithM_ (\n x -> (polls, n) <<- read x) [1..] . words =<< getLine

    C.forM_ (L.reverse [1..n-1]) ( \i -> do
        currentHeight   <- polls !  i :: IO Int
        oneBeforeHeight <- polls !? (i+1)
        twoBeforeHeight <- polls !? (i+2)

        let oneBeforeDiff = (abs . (currentHeight -)) <$> oneBeforeHeight :: Maybe Int
        let twoBeforeDiff = (abs . (currentHeight -)) <$> twoBeforeHeight :: Maybe Int

        oneBeforeCost <- C.join <$> dp !? (i+1) :: IO (Maybe Int)
        twoBeforeCost <- C.join <$> dp !? (i+2) :: IO (Maybe Int)

        let onePrevScore = (+) <$> oneBeforeDiff <*> oneBeforeCost
        let twoPrevScore = (+) <$> twoBeforeDiff <*> twoBeforeCost
        let minimal_score = minM onePrevScore twoPrevScore
        (dp, i) <<- minimal_score
        )

    print . M.fromJust =<< (dp ! 1)

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
