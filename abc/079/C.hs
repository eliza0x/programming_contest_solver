import Data.Maybe

main :: IO ()
main = do
    digits <- map (read . return) <$> getLine :: IO [Int]
    putStrLn . (++"=7") . tail . fromJust $ genFormula 0 "" digits

genFormula :: Int -> String -> [Int] -> Maybe String
genFormula n s [] = if n == 7 then Just s else Nothing
genFormula n s (x:xs) = let
    a = genFormula (n+x) (s++"+"++show x) xs
    b = genFormula (n-x) (s++"-"++show x) xs
    in case (isJust a, isJust b) of
        (True  ,    _) -> a
        (_     , True) -> b
        (False, False) -> Nothing

