import qualified Data.Array.Unboxed as A
import Data.Array.Unboxed ((!))
import Control.Monad

main :: IO ()
main = do
    [a,b] <- map read . words <$> getLine :: IO [Int]
    as <- A.listArray (1,a) . map read . words <$> getLine :: IO (A.UArray Int Int)
    bs <- A.listArray (1,b) . map read . words <$> getLine :: IO (A.UArray Int Int)
    -- print $ dfs (A.listArray ((1,1), (a,b)) [0,0..]) as bs 0 0 a b
    print $ dfsI as bs a b
    print . maximum $ dfsI as bs a b
    return ()

-- dfs :: A.UArray (Int, Int) Int 
dfsI :: A.UArray Int Int  
     -> A.UArray Int Int  
     -> Int 
     -> Int
     -> [Int]
dfsI as bs a b = dfs as bs 0 0 0 a b

dfs :: A.UArray Int Int 
    -> A.UArray Int Int 
    -> Int -- sum
    -> Int -- i
    -> Int -- l
    -> Int -- a
    -> Int -- b
    -> [Int]
dfs as bs sum i l a b
    | (i >= a) && (l >= b) = [sum]
    | otherwise = concat [dfs as bs (calc (even $ i+l) sum $ bs!(l+1)) i (l+1) a b | l < b]
               ++ concat [dfs as bs (calc (even $ i+l) sum $ as!(i+1)) (i+1) l a b | i < a]

calc :: Bool -> Int -> Int -> Int
calc f a b = if f then a+b else a-b -- a-b
