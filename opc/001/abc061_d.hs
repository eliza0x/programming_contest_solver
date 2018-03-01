import Control.Monad
import Data.Maybe
import Data.Array.IO
import Data.List

main :: IO ()
main = do
    [n, m] <- map read . words <$> getLine :: IO [Int]
    es  <- replicateM m ((\[a,b,c]->(a,b,-c)) . map read . words <$> getLine) :: IO [(Int, Int, Int)]
    arr <- newArray (1,n) 100000000000 :: IO (IOArray Int Int)

    writeArray arr 1 0

    arr' <- bellmanFord es arr
    putStrLn =<< if not (isJust arr') then return "inf" else do
        nc <- readArray (fromJust arr') n
        return . show . negate $ nc
    -- int . negate =<< readArray arr' n
    -- int . negate =<< readArray arr' n

bellmanFord :: [(Int, Int, Int)] -> IOArray Int Int -> IO (Maybe (IOArray Int Int))
bellmanFord es arr = do
    (s,l) <- getBounds arr
    forM_ [s..l] $ \i -> 
        forM_ [(f,t,c)|(f,t,c)<-es, f==i] $ \(f,t,c) -> do
            cost     <- readArray arr t
            fromCost <- readArray arr f
            when (cost > (fromCost+c)) $ writeArray arr t (fromCost + c)

    b <- foldr (||) False <$> (forM [(f,t,c)|i <- [s..l], (f,t,c)<-es, f==i] $ \(f,t,c) -> do
        cost     <- readArray arr t
        fromCost <- readArray arr f
        return $ cost > (fromCost+c))

    return $ if b then Nothing else Just arr

