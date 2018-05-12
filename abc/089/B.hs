import Control.Monad 
import Data.List

main = do
    _ <- read <$> getLine :: IO Int
    n <- length . group . sort . words <$> getLine  :: IO Int
    putStrLn $ if n == 3 then "Three" else "Four"
