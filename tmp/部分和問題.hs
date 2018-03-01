import qualified Data.ByteString.Char8 as B
import Control.Monad
import Data.Maybe
import Debug.Trace

import qualified Data.Array.Unboxed as U
import Data.Array.Unboxed ((!))
import qualified Data.Array.ST as A
import qualified Control.Monad.ST as S

main :: IO ()
main = do
    n <- read <$> getLine :: IO Int
    ns <- map read . words <$> getLine :: IO [Int]
    putStrLn $ if subsetSum (U.listArray (1,length ns) ns) n then "Yes" else "No"

subsetSum :: U.UArray Int Int
          -> Int 
          -> Bool
subsetSum ns n = S.runST $ do
    let (nsS, nsL) = U.bounds ns
    dp <- A.newArray ((0, 0), (n, n)) False :: S.ST s (A.STArray s (Int, Int) Bool)

    A.writeArray dp (0, 0) True

    forM [(j, i)|j<-[0..n], i<-[nsS-1..nsL]] $ \(j, i) -> do
        b  <- readArrayWithBound dp (j, i - 1)
        b' <- readArrayWithBound dp (j - (if nsS-1 == i then 0 else ns!i), i)
        A.writeArray dp (j, i) $ b || b'

    A.readArray dp (n, nsL)
    where
    readArrayWithBound :: A.STArray s (Int, Int) Bool -> (Int, Int) -> S.ST s Bool
    readArrayWithBound dp (n, m) = do
        ((sy, sx),(ly, lx)) <- A.getBounds dp
        case (sy <= n && sx <= m, n <= ly && m <= lx) of
            (True, True)  -> A.readArray dp (n, m)
            (False, True) -> return False
            _             -> error "DP: 範囲外参照"

