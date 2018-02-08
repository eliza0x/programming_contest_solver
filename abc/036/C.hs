import qualified Data.Set as S
import qualified Data.IntMap.Strict as M
import Data.IntMap.Strict ((!))
import Data.IORef
import Control.Monad

main :: IO ()
main = do
    _   <- read <$> getLine :: IO Int
    as  <- map read . lines <$> getContents :: IO [Int]
    set <- newIORef S.empty :: IO (IORef (S.Set Int))

    -- print =<< readIORef set
    forM_ as $ \i -> modifyIORef set (S.insert i)
    -- print =<< readIORef set
    
    dic <- newIORef M.empty :: IO (IORef (M.IntMap Int))
    set' <- readIORef set
    forM_ (zip [0..] $ S.toList set') $ \(v, k) -> 
        modifyIORef dic (M.insert k v) 
    
    dic' <- readIORef dic
    forM_ as $ \x -> 
        print (dic' ! x)
