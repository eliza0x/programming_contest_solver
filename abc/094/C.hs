import Data.List
import Control.Monad

main :: IO ()
main = do
    n <- read <$> getLine :: IO Int
    ns <- map read . words <$> getLine :: IO [Int]
    return ()
