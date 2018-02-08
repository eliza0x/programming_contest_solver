import qualified Data.Array.IO as A
import qualified Control.Monad as C
import qualified Data.List     as L
import qualified Data.Maybe    as M
 
main :: IO ()
main = do
    [n, q] <- map read . words <$> getLine :: IO [Int]
    tree <- newUnionFindTree n

    C.replicateM_ q $ do
        [p, a, b] <- map read . words <$> getLine :: IO [Int]
        case p of
            0 -> connectRoot tree a b
            1 -> do 
                aRoot <- traverseRoot tree a
                bRoot <- traverseRoot tree b
                putStrLn (if aRoot == bRoot then "Yes" else "No")
 
newtype UnionFind = UnionFind (A.IOArray Int Int)

newUnionFindTree :: Int -> IO UnionFind
newUnionFindTree n = do
    tree <- A.newArray (0,n-1) 0 :: IO (A.IOArray Int Int)
    C.forM_ [0..n-1] $ \i -> (tree, i) <<- i
    return $ UnionFind tree

connectRoot :: UnionFind -> Int -> Int -> IO ()
connectRoot (UnionFind tree) a b = do
    a' <- traverseRoot (UnionFind tree) a
    b' <- traverseRoot (UnionFind tree) b
    (tree, b') <<- a'
 
traverseRoot :: UnionFind -> Int -> IO Int
traverseRoot (UnionFind tree) i = do
    i' <- tree ! i
    if i == i' then return i
                else do
        r <- traverseRoot (UnionFind tree) i'
        -- rootが分かるのでついでに経路圧縮を行う
        (tree, i) <<- r
        return r

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
 
