import qualified Data.ByteString.Char8 as B
import Data.Maybe
import Control.Monad
import qualified Data.Array.IO as A

import qualified Data.Array.ST    as S
import qualified Control.Monad.ST as S

inf :: Int
inf = 100000000000

main :: IO ()
main = do
    [n, m] <- map (fst . fromJust . B.readInt) . B.words <$> B.getLine
    es <- replicateM m ((\[a,b,c]->(a,b,-c)) 
        . map (fst . fromJust . B.readInt) . B.words <$> B.getLine)
    p <- A.newArray (1, n) inf :: IO (A.IOUArray Int Int)
    A.writeArray p 1 0

    s <- bellmanFord p es
    putStrLn =<< if hasNegativeLoop (1, n) es
        then return "inf"
        else show . negate <$> A.readArray s n

bellmanFord :: A.IOUArray Int Int
               -> [(Int, Int, Int)]
               -> IO (A.IOUArray Int Int)
bellmanFord arr es = do
    (s,l) <- A.getBounds arr
    forM_ [(f,t,ec)|i<-[s..l], (f,t,ec)<-es, f==i] $ \(f,t,edgeCost) -> do
        fromCost <- A.readArray arr f
        toCost   <- A.readArray arr t
        when (toCost > fromCost+edgeCost) $
                A.writeArray arr t (fromCost+edgeCost)
    return arr

hasNegativeLoop :: (Int, Int)
                -> [(Int, Int, Int)]
                -> Bool
hasNegativeLoop (s,l) es = S.runST $ do
    arr <- S.newArray (s,l) 0 :: S.ST s (S.STArray s Int Int)
    or . concat <$> forM [s..l] (\i -> do 
        fromCost <- A.readArray arr i
        forM [(t,ec)|(f,t,ec)<-es, f==i, fromCost/=inf] $ \(t,edgeCost) -> do
            toCost   <- A.readArray arr t
            case (toCost > fromCost+edgeCost, i==l) of
                (False, _)    -> return False
                (True, True)  -> return True
                (True, False) -> do
                    A.writeArray arr t (fromCost+edgeCost)
                    return False)

