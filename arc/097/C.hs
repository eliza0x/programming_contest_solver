import qualified Data.Map as M
import Control.Monad

main = do
    s <- getLine
    n <- read <$> getLine
    let pre = foldr (\k m -> M.insert k 0 m) M.empty s
    let m = take n . foldr (++) "" $ map (\(c, n) -> replicate n c) . M.toAscList $ foldr (\k m -> M.insertWith (+) k 1 m) pre s
    putStrLn m
