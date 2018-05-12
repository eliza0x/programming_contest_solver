import qualified Data.Map.Strict as M
import Data.Map.Strict ((!?))
import qualified Data.List as L
import Data.Maybe

main = do
    [n, m] <- map read . words <$> getLine :: IO [Int]
    name <- map (\l->(head l, length l)) . L.group . L.sort <$> getLine
    let m = foldr (\c m -> M.insert c 0 m) M.empty ['A'..'Z'] :: M.Map Char Int
    kit <- foldr (\c m -> M.insertWith (+) c 1 m) m <$> getLine
    
