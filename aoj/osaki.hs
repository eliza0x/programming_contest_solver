import qualified Control.Monad as C
import qualified Data.List     as L
import Control.Applicative ((<$>))

solve :: Int -> IO ()
solve n = do
    rideAndLeftTimes <- concat <$> (C.forM [1..n] $ \_ -> do
        [ride, left] <- map read . words . filter (/= ':') <$> getLine :: IO [Int]
        return [(ride, 1), (left, -1)])
    print . maximum . scanl (+) 0 . map snd . L.sort $ rideAndLeftTimes
    main

main :: IO ()
main = do
    n <- read <$> getLine :: IO Int
    C.when (n /= 0) $ solve n


