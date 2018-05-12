import Control.Monad
import Control.Applicative
import qualified Data.List as L

main :: IO ()
main = do
    n <- read <$> getLine :: IO Int
    when (n /= 0) $ solve n

type PolyLine = [(Int, Int)]

getPolyLine :: IO PolyLine
getPolyLine = do
    n <- read <$> getLine :: IO Int
    replicateM n $ do
        [a, b] <- map read . words <$> getLine :: IO [Int]
        return (a, b)

lrs :: PolyLine -> String
lrs ((x,y):(x',y'):(x'',y''):l) = case (x==x', x<x', y<y', y'<y'', x'<x'') of
    (True,  _, b, _, True)  -> (if b then 'R' else 'L') : lrs ((x',y'):(x'',y''):l)
    (True,  _, b, _, False) -> (if b then 'L' else 'R') : lrs ((x',y'):(x'',y''):l)
    (False, b, _, True, _)  -> (if b then 'L' else 'R') : lrs ((x',y'):(x'',y''):l)
    (False, b, _, False, _) -> (if b then 'R' else 'L') : lrs ((x',y'):(x'',y''):l)
lrs _ = []

lengthOfPolyLines :: PolyLine -> [Int]
lengthOfPolyLines ((x,y):(x',y'):l) = 
    max (abs $ x'-x) (abs $ y'-y) : lengthOfPolyLines ((x',y'):l)
lengthOfPolyLines _ = []

rev = map (\c -> if c == 'R' then 'L' else 'R') . reverse

land :: [Int] -> [Int] -> [Int]
land [] _ = []
land (x:xs) ys = [x|L.elem x ys] ++ land xs ys

solve :: Int -> IO ()
solve n = do
    basePolyLine <- getPolyLine :: IO PolyLine
    let baseLR = lrs basePolyLine
    let baseLength = lengthOfPolyLines basePolyLine

    polyLines <- replicateM n getPolyLine :: IO [PolyLine]
    let dirPolyLines = map fst
            . filter (\(_, p) -> baseLR == p || rev baseLR == p) 
            . zip [1..] 
            . map lrs 
            $ polyLines
    let lengthPolyLines = map fst
            . filter (\(_, p) -> baseLength == p || L.reverse baseLength == p)
            . zip [1..] 
            . map lengthOfPolyLines
            $ polyLines
    mapM_ print $ land lengthPolyLines dirPolyLines
    putStrLn "-----"
    mapM_ print dirPolyLines
    putStrLn "-----"
    mapM_ print lengthPolyLines
    putStrLn "+++++"
    main
