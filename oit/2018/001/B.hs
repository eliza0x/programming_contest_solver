import Control.Monad
import qualified Data.List as L

main :: IO ()
main = do
    [n, m] <- map read . words <$> getLine :: IO [Int]
    roads <- L.group . L.sort . (++) [1..n] . concat
        <$> replicateM m (map read . words <$> getLine) :: IO [[Int]] 
    mapM_ print $ map (\l-> length l - 1) roads
