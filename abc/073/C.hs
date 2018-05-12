import qualified Control.Monad as C
import qualified Data.List as L

main :: IO ()
main = do
 n <- read <$> getLine :: IO Int
 ns <- map fst . filter (\(_, n) -> mod n 2 == 1) . map (\l->(head l, length l)) . L.group . L.sort <$> C.replicateM n (read <$> getLine) 
        :: IO [Int]
 print $ length ns

