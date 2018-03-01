import Control.Monad

main :: IO ()
main = do
    n <- read <$> getLine :: IO Int
    pos <- replicateM n ((\[x,y]->(x,y)) . map read . words <$> getLine) :: IO [(Double, Double)]

    print . sqrt . maximum $ map dist [(p, q)|p<-pos, q<-pos]

dist ((x,y),(x',y')) = (x-x')*(x-x')+(y-y')*(y-y')
