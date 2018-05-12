import qualified Data.Array.IO as A

commands = [[a,b] |a<-"ABXY", b<-"ABXY"]

main = do
    _  <- read <$> getLine :: IO Int
    cs <- getLine :: IO String
    print . minimum . map length $ [replace c c' cs |c<-commands, c'<-commands, c /= c']

sub :: String -> String -> String -> String
sub f t s
    | null s        = []
    | take 2 s == f = t ++ sub f t (drop 2 s)
    | otherwise     = head s : sub f t (tail s)

replace c c' = sub c "L" . sub c' "R"
