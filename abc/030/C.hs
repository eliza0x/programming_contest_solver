import qualified Data.List as L
import qualified Debug.Trace as D

main :: IO ()
main = do
    [n, m] <- map read . words <$> getLine :: IO [Int]
    [x, y] <- map read . words <$> getLine :: IO [Int]
    as <- map read . words <$> getLine :: IO [Int]
    bs <- map read . words <$> getLine :: IO [Int]
    print $ eatAs 0 x y as bs

eatAs :: Int   -- now
      -> Int   -- x
      -> Int   -- y
      -> [Int] -- as
      -> [Int] -- bs
      -> Int
eatAs time x y as bs =
    case (L.break (>= time) as) of
        (_, [])     -> 0
        (_, (n:xs)) -> eatBs (n+x) x y xs bs

eatBs :: Int   -- now
      -> Int   -- x
      -> Int   -- y
      -> [Int] -- as
      -> [Int] -- bs
      -> Int
eatBs time x y as bs =
    case (L.break (>= time) bs) of
        (_, [])     -> 0
        (_, (n:xs)) -> 1 + eatAs (n+y) x y as xs


