import Data.Bool
import Control.Monad
import Data.Array.Unboxed ((!))
import qualified Data.Array.Unboxed as U
import qualified Data.Array.IO as A

main = do
    n <- read <$> getLine :: IO Int
    ns <- U.listArray (0,n) . (0:) . map (read :: String -> Int) . words <$> getLine
    print =<< dp ns 

dp :: U.UArray Int Int -> IO Int
dp ns = do
    let (s, l) = U.bounds ns
    let sum = foldr (\i s->ns!i + s) 0 [s..l] :: Int
    map <- A.newArray ((s, 0), (l, sum)) False :: IO (A.IOArray (Int, Int) Bool)
    A.writeArray map (0, 0) True
    forM_ [(i, j)|i<-[s..l], j<-[0..sum], not (i==0 && j==0)] $ \(i, j) -> do
        c  <- readArr map (i-1, j)
        when c $ do
            A.writeArray map (i, j) $ c
            A.writeArray map (i, j+ns!i) c

    foldr (\b s -> bool 0 1 b + s) 0 <$> forM [0..sum] (\i -> A.readArray map (l, i))
    where
    readArr :: A.IOArray (Int, Int) Bool -> (Int, Int) -> IO Bool
    readArr arr (i,j) = do
        ((sy, sx), (ly, lx)) <- A.getBounds arr
        if sy <= i && i <= ly && sx <= j && j <= lx then A.readArray arr (i,j) else return False
