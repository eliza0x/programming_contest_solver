import qualified Data.Array.IO as A 
import Control.Monad

main :: IO ()
main = do
    n <- read <$> getLine :: IO Int
    e <- A.newArray (1, n) (-1) :: IO (A.IOUArray Int Int)
    forM_ [1, 3..n] $ \i -> A.writeArray e i i

    forM_ [3, 5..n] $ \i -> do
        c <- A.readArray e i
        when (-1 /= c) $
            forM_ [i*2, i*3..n] $ \l ->
                A.writeArray e l (-1)

    nc <- A.readArray e n
    putStrLn $ if -1 /= nc then "YES" else "NO"
 
