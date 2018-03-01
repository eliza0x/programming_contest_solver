import Data.List

main :: IO ()
main = do
    boxOut <- map read . words <$> getLine :: IO [Int]
    boxIn  <- map read . words <$> getLine :: IO [Int]

    print . maximum $ map sim [((a,b,c), (x,y,z))|[a, b, c] <- permutations boxOut, [x, y, z] <- permutations boxIn]

sim ((a,b,c), (x,y,z)) = div a x * div b y * div c z

