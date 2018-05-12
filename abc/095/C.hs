main :: IO ()
main = do
    [a, b, c, x, y] <- map read . words <$> getLine :: IO [Int]
    let cv  = (max x y) * 2 * c -- C only
    let abv = x*a + y*b -- A, B only

    let cxv = x*2*c + (if y-x >= 0 then (y-x)*b else 0)
    let cyv = y*2*c + (if x-y >= 0 then (x-y)*a else 0)

    print $ minimum [cv, abv, cxv, cyv]
