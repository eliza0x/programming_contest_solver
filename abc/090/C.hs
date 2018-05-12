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
    [a,b] <- getNums
    print $ if a >= 3 && b >= 3 then (a-2)*(b-2) 
                else if a == 2 || b == 2 then 0 
                    else if a == 1 && b == 1 then 1 else (a*b)-2
