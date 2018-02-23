import Control.Monad
import Data.Maybe
import qualified Data.ByteString.Char8 as B

main :: IO ()
main = do
    [n, k] <- map (fst . fromJust . B.readInteger) . B.words <$> B.getLine
    pos <- replicateM (fromIntegral n) ((\[a,b]->(a,b)) . map (fst . fromJust . B.readInteger) . B.words <$> B.getLine)
    print . minimum $ concatMap
        (\(p,p')-> [(fst p'-fst p)*(snd p'-snd p)|innerPoints pos p p' >= k])
        [((x,y), (x',y'))|x<-map fst pos, x'<-map fst pos, y<-map snd pos, y'<- map snd pos, x<=x', y<=y'] 
    
innerPoints :: [(Integer, Integer)] -> (Integer, Integer) -> (Integer, Integer) -> Integer
innerPoints pos (x,y) (x',y') = sum . map (\x->if x then 1 else 0) $ flip map pos
    (\(x'',y'')->x<=x'' && x''<=x' && y<=y'' && y''<=y')

