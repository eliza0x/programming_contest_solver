import Control.Monad 
import Data.List
import qualified Data.ByteString.Char8 as B

main = do
    n <- read <$> getLine :: IO Int
    names <- replicateM n B.getLine
    let m = cnt 'M' names
    let a = cnt 'A' names
    let r = cnt 'R' names
    let c = cnt 'C' names
    let h = cnt 'H' names
    let l = zip [1..] [m,a,r,c,h] 
    print . sum $ [i*j*k|(p,i)<-l,(p',k)<-l,(p'',j)<-l,p<p',p'<p'']
    
cnt k names = length . filter (\s-> B.head s == k) $ names

