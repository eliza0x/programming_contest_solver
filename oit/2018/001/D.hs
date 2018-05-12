main :: IO ()
main = do
    [sx, sy, tx, ty] <- map read . words <$> getLine :: IO [Int]
    let up    = if sy < ty then "U" else "D"
    let down  = if sy < ty then "D" else "U"
    let right = if sy < ty then "R" else "L"
    let left  = if sy < ty then "L" else "R"

    putStrLn $ case (sy /= ty, sx /= tx) of
        (True, True) ->  gen ty sy up ++ gen tx sx right ++ gen ty sy down ++ gen tx sx left
            ++ left ++ gen ty sy up ++ up ++ gen tx sx right ++ right ++ down
            ++ right ++ gen ty sy down ++ down ++ gen tx sx left ++ left ++ up
        (True, False) -> gen ty sy up ++ right ++ gen ty sy down ++ left
            ++ left ++ gen ty sy up ++ right
            ++ up ++ right ++ right ++ gen ty sy down ++ down ++ down ++ left ++ left ++ up
        (False, True) -> gen tx sx right ++ down ++ gen tx sx left ++ up
            ++ up ++ gen tx sx right ++ down
            ++ right ++ down ++ down ++ gen tx sx left ++ left ++ left ++ up ++ up ++ right

gen :: Int -> Int -> String -> String
gen n m c = concat $ replicate (abs $ n-m) c

