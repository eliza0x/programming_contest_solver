main :: IO ()
main = do
    n <- read <$> getLine :: IO Double
    rs <- (/ n) . sum . map toGPA <$> getLine :: IO Double
    print rs


toGPA c = case c of
    'A' -> 4
    'B' -> 3
    'C' -> 2
    'D' -> 1
    'F' -> 0


