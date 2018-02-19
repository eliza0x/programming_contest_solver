import qualified Data.Sequence   as S
import qualified Data.Map.Strict as M
import qualified Control.Monad   as C
import Data.Sequence ((><))
import Data.Map.Strict ((!))
 
import Data.Maybe
import Debug.Trace
 
type Queue  = S.Seq
 
main :: IO ()
main = do
    [h, w] <- map read . words <$> getLine :: IO [Int]
    let (sy, sx) = (1, 1)
    let (gy, gx) = (h, w)
 
    -- ここは入力を受け取っているだけなので気にしないで
    input <- C.replicateM h getLine :: IO [[Char]]
    let c = map (\(y, line) ->
                map (\(x, c) ->
                    if c == '#' then ((y, x), Nothing) else ((y, x), Just 1000000)
                    ) (zip [1..] line) 
            ) (zip [1..] input)

    let shortestPath = bfs (M.insert (sy, sx) (Just 0) . M.fromList $ concat c) 
                              (h,w)
                            $ S.fromList [(sy, sx)]
    let cnt = (foldr (\a b -> (if a=='.' then 1 else 0) + b) 0 $ concat input)
    let p = fromJust $ shortestPath ! (gy, gx)
    print $ if p/=1000000 then cnt - (fromJust $ shortestPath ! (gy, gx)) - 1
                          else -1
 
-- 幅優先探索
bfs :: M.Map (Int, Int) (Maybe Int) -- 地図
    -> (Int, Int)
    -> Queue (Int, Int)
    -> M.Map (Int, Int) (Maybe Int)
bfs c (h,w) queue 
    | S.null queue = c
    | otherwise    = let
        (y, x) = queue `S.index` 0
        q = S.tails queue `S.index` 1
        -- qはqueueの追加分, cは地図の変更分
        (q', c') = unzip . concat . flip map (destinations y x) $ \(ny, nx) ->
            if 1<=ny && ny<=h && 1<=nx && nx<=w then
                case (c!(y,x), c!(ny,nx)) of
                    (Just a, Just b) -> if (a+1 >= b) then [] else [((ny, nx) ,((ny, nx), Just $ a+1))]
                    _                -> []
                else []
        in bfs (override c $ M.fromList c') (h,w) (q >< S.fromList q')
    where
    -- Keyが重複していれば二つ目の引数のMapで一つ目のMapを上書き
    override :: (Ord k) => M.Map k a -> M.Map k a -> M.Map k a
    override = M.unionWith (\a b -> b)
    -- この問題では四方に動けるので、その行き先を作っている
    destinations y x = [(y+1, x), (y-1, x),(y, x+1),(y, x-1)]

