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
    print . length $ filter isParindrome [a..b]

isParindrome :: Int -> Bool
isParindrome n = let
    [a1,a2,_,a4,a5] = show n
    in a1 == a5 && a2 == a4
