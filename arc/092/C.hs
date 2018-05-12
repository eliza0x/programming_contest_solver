import Control.Monad
import Data.List
-- import Data.Bits
import qualified Data.Set as S

getNum :: IO Int
getNum = read <$> getLine

getNums :: IO [Int]
getNums = map read . words <$> getLine

main :: IO ()
main = do
    n    <- getNum
    red  <- replicateM n ((\[a,b]->(a,b)) <$> getNums)
    blue <- replicateM n ((\[a,b]->(a,b)) <$> getNums)
    -- 中間値: 可能性のあるもの
    let ns =  map (\(_,_,l)->l) . filter (\(n,_,_)->n/=0) . sort . map (\(p, l)->(length l, p, l)) $ fil red blue
    -- mapM_ print ns
    print $ solve ns S.empty

solve :: [[(Int, Int)]] -> S.Set (Int, Int) -> Int
solve [] set = S.size set
solve (x:xs) set = case (find (`S.notMember` set) x) of
    Nothing -> solve xs set
    Just p  -> solve xs $ S.insert p set

fil :: [(Int,Int)] -> [(Int,Int)] -> [((Int, Int), [(Int,Int)])]
fil red blue = flip map blue $ \(c,d) ->
    ((c,d), filter (\(a,b)->a<c&&b<d) red)

