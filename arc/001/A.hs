import Data.List

main :: IO ()
main = do
    n <- read <$> getLine :: IO Int
    cs <- map length . group . sort . map ((read :: String -> Int) . return) . (++"1234") <$> getLine :: IO [Int]
    putStrLn $ show (maximum cs - 1) ++ " " ++ show (minimum cs - 1)

