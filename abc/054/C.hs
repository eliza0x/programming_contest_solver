import qualified Control.Monad as C
import qualified Data.Array as A
import Data.Array ((!))
import qualified Data.Map.Strict as M

main :: IO ()
main = do
    [n, m] <- map read . words <$> getLine :: IO [Int]
    edges <- C.replicateM m (l2t . map read . words <$> getLine)
    let graph = A.array ((1,1), (n,n)) ([((i,j), False)|i<-[1..n],j<-[1..n]] 
                ++ concat [[((i,j), True), ((j,i), True)]|(i,j)<-edges])
    print . maximum . (0:) . snd . unzip . M.toList 
        $ dfs (M.fromList [(i, 0)|i<-[1..n]]) graph [] 1 n 
    

dfs :: M.Map Int Int 
    -> A.Array (Int, Int) Bool
    -> [Int]
    -> Int -- cur
    -> Int -- cnt
    -> M.Map Int Int
dfs memo graph already cur vertexesCnt = let
    memo'    = M.update (\n -> Just $ n+1) cur memo
    already' = cur:already
    nexts'   = filter (\n -> notElem n already && graph!(cur,n)) [1..vertexesCnt]
    in case (length already' == vertexesCnt, length nexts') of
        (True, _) -> memo'
        (_, 0)    -> M.empty
        (_, _)    -> foldr (M.unionWith (+)) M.empty
                     $ map (\next -> dfs memo' graph already' next vertexesCnt) nexts'

l2t (x:x':[]) = (x,x')
{-# INLINE l2t #-}
