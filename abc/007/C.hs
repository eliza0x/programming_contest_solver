import qualified Data.Sequence   as S
import qualified Data.Map.Strict as M
import qualified Control.Monad   as C
import Data.Sequence ((><))
import Data.Map.Strict ((!))

import Data.Maybe

type Queue  = S.Seq

main :: IO ()
main = do
    [r, c]   <- map read . words <$> getLine :: IO [Int]
    [sy, sx] <- map read . words <$> getLine :: IO [Int]
    [gy, gx] <- map read . words <$> getLine :: IO [Int]

    -- ここは入力を受け取っているだけなので気にしないで
    c <- C.forM [1..r] $ \y -> do
        cs <- getLine :: IO [Char]
        return $ flip map (zip cs [1..c]) $ \(a, x)-> 
            if a == '#' then ((y, x), Nothing) 
                        else ((y, x), Just 1000000)
    let shortestPath = bfs (M.insert (sy, sx) (Just 0) . M.fromList $ concat c) 
                            $ S.fromList [(sy, sx)]
    print . fromJust $ shortestPath ! (gy, gx)

-- 幅優先探索
bfs :: M.Map (Int, Int) (Maybe Int) -- 地図
    -> Queue (Int, Int)
    -> M.Map (Int, Int) (Maybe Int)
bfs c queue 
    | S.null queue = c
    | otherwise    = let
        (y, x) = queue `S.index` 0
        q = S.tails queue `S.index` 1
        -- qはqueueの追加分, cは地図の変更分
        (q', c') = unzip . concat . flip map (destinations y x) $ \(ny, nx) ->
            case (c!(y,x), c!(ny,nx)) of
                (Just a, Just b) -> if (a+1 >= b) then [] else [((ny, nx) ,((ny, nx), Just $ a+1))]
                _                -> []
        in bfs (override c $ M.fromList c') (q >< S.fromList q')
    where
    -- Keyが重複していれば二つ目の引数のMapで一つ目のMapを上書き
    override :: (Ord k) => M.Map k a -> M.Map k a -> M.Map k a
    override = M.unionWith (\a b -> b)
    -- この問題では四方に動けるので、その行き先を作っている
    destinations y x = [(y+1, x),(y-1, x),(y, x+1),(y, x-1)]

