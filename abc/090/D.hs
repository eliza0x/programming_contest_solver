import Control.Monad
import Data.List
import Data.Maybe
import qualified Data.ByteString.Char8 as B

getNum :: IO Int
getNum = fst . fromJust . B.readInt <$> B.getLine

getNums :: IO [Int]
getNums = map (fst . fromJust . B.readInt) . B.words <$> B.getLine :: IO [Int]

main :: IO ()
main = do
    [n,k] <- getNums
       

