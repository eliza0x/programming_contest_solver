main :: IO ()
main = do
    es <- map read . words <$> getLine :: IO [Int]
    b <- read <$> getLine :: IO Int
    ls <- map read . words <$> getLine :: IO [Int]
    let s = sum . map (\b->if b then 1 else 0) $ map (`elem` es) ls :: Int
    let l = length . filter (==b) $ ls :: Int

    case (s, l) of 
        (6, _) -> print 1
        (5, 1) -> print 2
        (5, _) -> print 3
        (4, _) -> print 4
        (3, _) -> print 5
        (_, _) -> print 0
