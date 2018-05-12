import Control.Monad 
import qualified Data.Array.IO as A

main :: IO ()
main = do
    n <- read <$> getLine :: IO Int
    m <- memo
    when (n /= 0) $ do
        solve m n
        main

pollock n = div (n * (n+1) * (n+2)) 6

memo :: IO (A.IOUArray Int Int)
memo = do
    let size = 1000000
    memo <- A.newArray (0, size) (-1) :: IO (A.IOUArray Int Int)
    A.writeArray memo 0 0
    forM_ [1..100] $ \i -> do
        let pNum = pollock i
        forM_ [j | j<-[0..size]] $ \j -> do
            x <- A.readArray memo j
            when (j + pNum <= size) $ do
                m <- A.readArray memo (j + pNum)
                case (m /= -1, x /= -1) of
                    (True, True)  -> A.writeArray memo (j + pNum) $ min m (x + 1)
                    (True, False) -> A.writeArray memo (j + pNum) $ m 
                    (False, True) -> A.writeArray memo (j + pNum) $ x + 1
    return memo

solve :: A.IOUArray Int Int -> Int -> IO ()
solve memo n = print =<< A.readArray memo n
    
