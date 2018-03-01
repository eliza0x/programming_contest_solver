main = do
    inp <- read <$> getLine
    print $ lucas 0 0 0 inp

lucas :: Integer -> Integer -> Integer -> Integer -> Integer
lucas _ _ 0 m = if 0==m then 2 else lucas 0 0 1 m
lucas _ _ 1 m = if 1==m then 1 else lucas 1 2 2 m
lucas p q n m = if n == m
    then p + q
    else lucas (p + q) p (n+1) m
