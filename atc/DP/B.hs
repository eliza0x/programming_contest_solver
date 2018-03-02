import Data.Array.Unboxed ((!))
import qualified Data.Array.Unboxed as U
import qualified Data.Array.IO as A
import Control.Monad
import Data.Maybe
import Data.List
import Data.Bool

main :: IO ()
main = do
    [a, b] <- map read . words <$> getLine :: IO [Int]
    as <- U.listArray (1, a) . map read . words 
        <$> getLine :: IO (U.UArray Int Int)
    bs <- U.listArray (1, b) . map read . words 
        <$> getLine :: IO (U.UArray Int Int)

    print as 
    print bs 
    t <- dp as bs a b
    forM_ [(i,j)|i<-[0..a], j<-[0..b]] $ \(i,j) -> do
        putStr $ replicate (3 - length (show $ t!(i,j))) ' '
        putStr . show $ t!(i,j)
        when (j==b) $ putStrLn ""

    print $ t ! (a,b)

dp :: U.UArray Int Int  -- as
   -> U.UArray Int Int  -- bs
   -> Int
   -> Int
   -> IO (U.UArray (Int, Int) Int)
dp as bs a b = do
    dp <- A.newArray ((0,0), (a, b)) 0 :: IO (A.IOArray (Int, Int) Int)
    forM_ [(i,j)|i<-reverse [0..a], j<-reverse [0..b]] $ \(i,j) -> do
        c  <- if i+1<=a then Just <$> A.readArray dp (i+1, j) else return Nothing
        c' <- if j+1<=b then Just <$> A.readArray dp (i, j+1) else return Nothing
        let ac = if i>0 then Just $ as!i else Nothing
        let bc = if j>0 then Just $ bs!j else Nothing
        case (mod ((a+b) - (i+j)) 2 == 1, (+) <$> c <*> ac, (+) <$> c' <*> bc) of
            (True,  Nothing, Nothing) -> A.writeArray dp (i,j) $ maximum [fromMaybe 0 ac, fromMaybe 0 bc, fromMaybe 0 c, fromMaybe 0 c']
            (_,     Nothing, Nothing) -> A.writeArray dp (i,j) $ minimum [fromMaybe 0 ac, fromMaybe 0 bc, fromMaybe 0 c, fromMaybe 0 c']
            (True,  Nothing, Just n)  -> A.writeArray dp (i,j) n
            (_,     Nothing, Just n)  -> A.writeArray dp (i,j) $ fromMaybe 0 c'
            (True,  Just n,  Nothing) -> A.writeArray dp (i,j) n
            (_,     Just n,  Nothing) -> A.writeArray dp (i,j) $ fromMaybe 0 c
            (True,  Just n,  Just n')  -> A.writeArray dp (i,j) $ max n n'
            (False, Just n,  Just n')  -> A.writeArray dp (i,j) $ min n n'
    A.freeze dp
