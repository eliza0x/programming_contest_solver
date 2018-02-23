import qualified Data.ByteString.Char8 as B
import qualified Data.Array.IO as A
import Control.Monad
import Data.Maybe

main :: IO ()
main = do
    [h, w] <- map (fst . fromJust . B.readInt) . B.words <$> B.getLine
    cost <- A.newListArray ((0,0),(9,9)) . concat =<< replicateM 10
        (map (fst . fromJust . B.readInt) . B.words <$> B.getLine) :: IO (A.IOUArray (Int,Int) Int)

    square <- concat <$> replicateM h 
        (map (fst . fromJust . B.readInt) . B.words <$> B.getLine) :: IO [Int]

    cost' <- warshallFloyd cost

    print . sum =<< forM square 
        (\i -> if i == (-1) then return 0 else A.readArray cost' (i, 1))

warshallFloyd :: A.IOUArray (Int, Int) Int
              -> IO (A.IOUArray (Int, Int) Int)
warshallFloyd arr = do
    forM_ [(k,j,i)|k<-[0..9], j<-[0..9], i<-[0..9]] $ \(k,j,i) -> do
        ij <- A.readArray arr (i,j)     
        ik <- A.readArray arr (i,k)     
        kj <- A.readArray arr (k,j)     
        A.writeArray arr (i,j) $ min ij (ik+kj)
    return arr
