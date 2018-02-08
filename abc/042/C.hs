import Data.List
import Data.Maybe
import Control.Monad
import Debug.Trace

main :: IO ()
main = do
    [n, k] <- map read . words <$> getLine :: IO [Int]
    canNotUse <- map read . words <$> getLine :: IO [Int]
    let canUse = [0..10] \\ canNotUse
    let reWrited = reWrite (map (read . return) $ show n) canNotUse canUse
    let carryUped = carryUp canUse $ reWrited
    print canUse
    print reWrited
    print carryUped
    putStrLn . concatMap (\n->show n) $ carryUped

reWrite :: [Int] -> [Int] -> [Int] -> [Int]
reWrite [] _ _ = []
reWrite (x:xs) canNotUse canUse = do
    if elem x canNotUse
        then findBigger x canUse : reWrite xs canNotUse canUse
        else x : reWrite xs canNotUse canUse

findBigger :: Int ->  [Int] -> Int
findBigger n xs = let
    in fromJust $ find (> n) xs

carryUp :: [Int] -> [Int] -> [Int] 
carryUp canUse ns = carryUp' canUse [] 0 . reverse $ ns

carryUp' :: [Int] -> [Int] -> Int -> [Int] -> [Int] 
carryUp' canUse tail carry []     = if carry == 0 then tail else minimum (canUse \\ [0]) : replicate (length tail) (minimum canUse) 
carryUp' canUse tail carry (n:ns) = case ((carry+n) > 9, find (> n) canUse) of
    (False, _)       -> carryUp' canUse (n:tail)  0 ns 
    (True, Just n')  -> carryUp' canUse (n':tail) 0 ns 
    (True, Nothing)  -> carryUp' canUse (0:tail)  1 ns 
