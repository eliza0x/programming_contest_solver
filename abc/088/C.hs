main :: IO ()
main = do
    [c11, c12, c13] <- map read . words <$> getLine :: IO [Int]
    [c21, c22, c23] <- map read . words <$> getLine :: IO [Int]
    [c31, c32, c33] <- map read . words <$> getLine :: IO [Int]
    let c2sub1 = c21 - c11 
    let c3sub1 = c31 - c11
    let r2sub1 = c12 - c11
    let r3sub1 = c13 - c11

    putStrLn $ if c22-c12==c2sub1 && c23-c13==c2sub1 
               && c32-c12==c3sub1 && c33-c13==c3sub1 
               && c22-c21==r2sub1 && c32-c31==r2sub1 
               && c23-c21==r3sub1 && c33-c31==r3sub1 then "Yes" else "No"

