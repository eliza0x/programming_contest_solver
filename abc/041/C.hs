import Data.List 
import Control.Monad

main :: IO ()
main = do
    _ <- read <$> getLine :: IO Int
    as <- reverse . sort . (`zip` [1..]) . map read . words 
        <$> getLine :: IO [(Int, Int)]
    forM_ as $ \(_, i) -> print i
