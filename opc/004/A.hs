main = do
    [h,w,a,b] <- map read . words <$> getLine :: IO [Int]
    
    let s  = reverse $ map (combN (h-a)) [1..w]
    let s' = reverse $ map (combN (a))   [1..(w-b)+1]
    print $ combN 3 1
    print $ s
    print $ s'
    print . sum $ zipWith (|*) s s'

combN :: Int -> Int -> Int
combN n r
  | n < r = 0
  | otherwise = fact n |* fact r |* fact (n - r)
 

fact :: Int -> Int
fact 0 = 1
fact n = n |* fact (n|-1)

factN :: Int -> Int -> Int
factN 0 _ = 1
factN _ 0 = 1
factN n m = n |* factN (n|-1) (m|-1)


modN :: Int
modN = 10^9+7
 
(|+) :: Int -> Int -> Int
(|+) n m = (`mod` modN) $ n + m 

(|-) :: Int -> Int -> Int
(|-) n m = (`mod` modN) $ n - m 

(|*) :: Int -> Int -> Int
(|*) n m = (`mod` modN) $ (n `mod` modN) * (m `mod` modN) 

(|^) :: Int -> Int -> Int
(|^) x n
  | n == 0    = 1
  | even n    = mod (x*x) modN |^ div n 2
  | otherwise = (`mod` modN) $ (x |^ (n - 1)) * x

(|/) :: Int -> Int -> Int
(|/) n m = n |* (m |^ (modN - 2))

