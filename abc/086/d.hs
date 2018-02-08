import Data.Map.Lazy hiding (map, filter)
import qualified Data.Map.Lazy as M
import Data.IORef
import Control.Monad
import qualified Data.List as L
import Data.Monoid

data Color = B | W | M deriving (Show, Ord)

instance Monoid Color where
    mempty      = M
    mappend W W = W
    mappend W B = M
    mappend B W = M
    mappend B B = B
    mappend M _ = M
    mappend _ M = M

instance Eq Color where
    (==) W B = False
    (==) B W = False
    (==) W W = True
    (==) B B = True
    (==) M _ = True
    (==) _ M = True

main :: IO ()
main = do
    restriction <- newIORef $ empty :: IO (IORef (Map (Int, Int) Color))
    [n, k] <- map read . words <$> getLine :: IO [Int]
    forM [1..n] (\_ -> do
        (x, y, c) <- (\[x, y, c]->(read x, read y, if c=="B" then B else W))
            . words <$> getLine :: IO (Int, Int, Color)
        modifyIORef restriction $ insertWith (<>) (mod x (k*2), mod y (k*2)) c
        )
    print =<< readIORef restriction
    ans <- readIORef restriction
    -- print $ (sum $ mapWithKey (step k) ans)
    print $ map (\o->sum $ mapWithKey (\x y->step o k x y) ans) 
        [(x,y)|x <- [0..k*2], y <- [0..k*2]]
    -- print $ (sum $ mapWithKey (step' k) ans)
    -- print $ max (sum $ mapWithKey (step k) ans) (sum $ mapWithKey (step' k) ans)

step :: (Int, Int) -> Int -> (Int, Int) -> Color -> Int
step (ox, oy) k (x, y) c = let
    in if ((ox+x) <  k && (oy+y) <  k && c == W)
       || ((ox+x) >= k && (oy+y) >= k && c == W)
       || ((ox+x) >= k && (oy+y) <  k && c == B)
       || ((ox+x) <  k && (oy+y) >= k && c == B) then 1 else 0

{-
step' :: Int -> (Int, Int) -> [Color] -> Int
step' k (x, y) cs = let
    w = elem W cs
    b = elem B cs
    in if (x <  k && y <  k && w)
       || (x >= k && y >= k && w)
       || (x >= k && y <  k && b)
       || (x <  k && y >= k && b) then 1 else 0
-}
