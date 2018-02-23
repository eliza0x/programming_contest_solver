import qualified Data.Array.IO as A
import qualified Data.Bits as B
import Data.Bits ((.|.), (.&.))
import Control.Monad

type Array a = A.IOUArray Int a

main :: IO ()
main = do
    [n, m] <- map read . words <$> getLine :: IO [Int]
    member <- A.newArray (1, n) 0 :: IO (Array Int)
    forM_ [1..n] $ \i -> 
        A.writeArray member i (B.shiftL 1 (i-1))

    replicateM_ m $ do
        [x, y] <- map read . words <$> getLine :: IO [Int]
        bx <- A.readArray member x
        by <- A.readArray member y
        A.writeArray member x $ bx .|. B.shiftL 1 (y-1)
        A.writeArray member y $ by .|. B.shiftL 1 (x-1)

    ns <- forM [1..B.bit n-1] $ \i -> do
        bs <- forM (intFromBits i) $ \l ->
            A.readArray member l
        return $ if (foldr (.&.) (head bs) bs .&. i) == i then length bs else 0

    print $ maximum ns

intFromBits :: Int -> [Int]
intFromBits bits = concatMap 
    (\i-> if bits .&. B.shiftL (1::Int) i > 0 then [i+1] else []) [0..11]
