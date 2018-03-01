import Debug.Trace

main :: IO ()
main = do
    [m, n, p] <- map read . words <$> getLine :: IO [Int]
    print $ sim m n p 0

sim m n p a = case (div p m > 0, div (p+a) m > 0) of
    (False, False) -> p
    (True, _) -> p + sim m n (div p m * n) (mod p m + a)
    (_, True) -> p + sim m n (div (p+a) m * n) (mod (p+a) m)
