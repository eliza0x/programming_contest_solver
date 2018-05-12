import qualified Control.Monad as C
import qualified Data.List as L

main = do
    n <- read <$> getLine :: IO Int
    (s:ss) <- map L.sort <$> C.replicateM n getLine :: IO [String]
    putStrLn $ foldr merge s ss

merge [] _ = []
merge _ [] = []
merge (s:ss) (s':ss') = case (s == s', s < s') of
    (True, _) -> s:merge ss ss'
    (_, True) -> merge ss (s':ss')
    (_,False) -> merge (s:ss) ss'

