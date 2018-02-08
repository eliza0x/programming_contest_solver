import qualified Data.Array.IO as A
import Control.Monad 

main :: IO ()
main = do
    [n, k] <- map read . words <$> getLine :: IO [Int]
    input <- getContents
    ss <- A.newArray (1, n) 0 :: IO (A.IOArray Int Int)
    forM_ (zip [1..] . map read . lines $ input) $ \(i, s) ->
        (ss, i) <<- s
    
    isConteinZero <- elemM ss 0
    if isConteinZero 
        then print n
        else print . maximum =<< cntSubList ss 0 1 1 1 n k

cntSubList :: A.IOArray Int Int
           -> Int   -- cnt
           -> Int   -- mul
           -> Int   -- start
           -> Int   -- last
           -> Int   -- n
           -> Int   -- k
           -> IO [Int]
cntSubList arr cnt mul s l n k = if l > n
    then return [cnt]
    else do
    cur <- arr ! l
    let mul' = mul * cur
    {-
    putStr "cnt: "
    print cnt
    putStr "mul': "
    print mul'
    putStr "s: "
    print s
    putStr "l: "
    print l
    putStrLn ""
    -}
    case (mul' <= k, s == l) of
        (True, _)      -> -- 継続
            cntSubList arr (cnt+1) mul' s (l+1) n k
        (False, True)  -> -- start, last共にスライド
            (cnt :) <$> cntSubList arr 0 1 (s+1) (l+1) n k
        (False, False) -> do -- over k
            fir <- arr ! s
            {-
            putStr "fir: "
            print fir
            -}
            let mul'' = div mul fir
            (cnt :) <$> cntSubList arr (cnt-1) mul'' (s+1) l n k

elemM :: A.IOArray Int Int -> Int -> IO Bool
elemM arr n = do
    (s, l) <- A.getBounds arr
    elem n <$> mapM (arr !) [s..l]

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
 
