import qualified Data.ByteString.Char8 as BC8
import qualified Data.Maybe as M
-- import qualified Data.IntMap.Lazy as M
import Control.Monad
import Data.List
import Debug.Trace

main :: IO ()
main = do
    [n, m] <- map (fst . M.fromJust . BC8.readInt) . BC8.words <$> BC8.getLine
    edges <- replicateM m ((\[a, b]->(a,b)) . map (fst . M.fromJust . BC8.readInt) . BC8.words <$> BC8.getLine)
    -- print edges
    print . length $ filter (\i -> not (isConnectedGraph (edges \\ [edges!!i]) n)) [0..m-1]

isConnectedGraph :: [(Int, Int)] -- グラフ
                 -> Int          -- 頂点の数
                 -> Bool
isConnectedGraph graph n = (==0) . length $ [1..n] \\ isConnectedGraph' (graph++map (\(f,t)->(t,f)) graph) [] (fst $ head graph)

isConnectedGraph' :: [(Int, Int)] -> [Int] -> Int -> [Int]
isConnectedGraph' [] already pos = pos:already
isConnectedGraph' graph already pos = let
    ns = filter (\(f,t)->pos==f && not (elem t already)) graph
    in if null ns
        then nub $ pos:already
        else nub . foldr (++) [] $  map (\(f,t) -> isConnectedGraph' graph (nub $ pos:already ++ map snd ns) t) ns 
