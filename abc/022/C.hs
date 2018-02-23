import Control.Monad
import Data.Maybe
import qualified Data.ByteString.Char8 as B
import qualified Data.Array.IO as A

type Square = A.IOUArray (Int, Int)

main :: IO ()
main = do
    [n, m] <- map (fst . fromJust . B.readInt) . B.words <$> B.getLine
    dist <- A.newArray ((0,0), (n, n)) 1000000000 :: IO (Square Int)
    replicateM_ m (do
        [u, v, l] <- map (fst . fromJust . B.readInt) . B.words <$> B.getLine
        A.writeArray dist (u, v) l
        A.writeArray dist (v, u) l )

    forM_ [(k,i,j)|k<-[2..n], i<-[2..n], j<-[2..n]] $ \(k, i, j) -> do
        ij <- A.readArray dist (i, j)
        ik <- A.readArray dist (i, k)
        kj <- A.readArray dist (k, j)
        A.writeArray dist (i, j) $ min ij (ik+kj)

    l <- filter (< 1000000000) <$>
        (forM [(i,j)| i<-[1..n], j<-[1..n], i/=j] $ \(i,j) -> do
            c  <- A.readArray dist (1,i)
            c' <- A.readArray dist (1,j)
            if not (c/=1000000000 && c'/=1000000000)
                then return 1000000000
                else do c'' <- A.readArray dist (i, j)
                        return $ c''+c+c')

    print $ if null l then -1 else minimum l

