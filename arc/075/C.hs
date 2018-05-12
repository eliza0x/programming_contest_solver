import qualified Data.IntSet as S
import Control.Monad
import Data.Maybe

main = do
    n <- read <$> getLine
    ss <- map read <$> replicateM n getLine :: IO [Int]
    print . S.findMax . S.insert 0 . S.filter (\n -> mod n 10 /= 0) 
        $ foldr dp (S.singleton 0) ss

dp x set = let
    set' = S.map (+x) set
    in (set `S.union` set')
