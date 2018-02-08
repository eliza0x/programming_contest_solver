import Control.Monad
import Debug.Trace

data Travel = Travel {
    time  :: Int,
    x :: Int,
    y :: Int
    } deriving (Show, Eq)

main :: IO ()
main = do
    n <- read <$> getLine :: IO Int
    travel <- forM [1..n] ( \_ -> do
            [t, x, y] <- map read . words <$> getLine :: IO [Int]
            return $ Travel t x y
        )
    putStrLn $ if move travel $ Travel 0 0 0 then "Yes" else "No"

move :: [Travel]
     -> Travel -- current status
     -> Bool
move [] _ = True
move ((Travel time x y):xs) (Travel ctime cx cy) = let
    canMove = let a = (time - ctime) - (abs (x - cx) + abs (y - cy)) :: Int
        in a >= 0 && even a  :: Bool
    nextStates = Travel time x y :: Travel
    in canMove && move xs nextStates
