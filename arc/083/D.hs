import qualified Data.Array.IO as A
import Data.Array.Unboxed as U
import Control.Monad
import Data.Maybe
import qualified Data.ByteString.Char8 as B

inf = 100000000000 :: Int

main = do
    n <- read <$> getLine :: IO Int
    as <- warshall_fluyd =<< A.newListArray ((1,1),(n,n)) . concat =<< 
            replicateM n (map (fst . fromJust . B.readInt) . B.words <$> B.getLine) 
    print $ case as of
        Just as' -> sum [as'!(i,j)|i<-[1..n], j<-[1..n], i<j, i/=j, as'!(i,j) < inf]
        Nothing  -> -1

warshall_fluyd :: A.IOArray (Int,Int) Int -> IO (Maybe (U.UArray (Int,Int) Int))
warshall_fluyd arr = do
    ((s,_),(l,_)) <- A.getBounds arr
    f <- and <$> (forM [(k,i,j)|k<-[s..l], i<-[s..l], j<-[s..l], i/=j, k/=j, i/=k] $ \(k,i,j) -> do
        ik <- A.readArray arr (i,k)
        kj <- A.readArray arr (k,j)
        ij <- A.readArray arr (i,j)
        if all (/=inf) [ik,kj,ij]
            then if ik+ kj == ij
                then do A.writeArray arr (i,j) inf
                        return True
                else return (not (ik+kj < ij))
            else return True)
    if f then Just <$> A.freeze arr else return Nothing

