main :: IO ()
main = do
    k <- (\s->head s) <$> getLine :: IO Char
    putStrLn . filter (/=k) =<< getLine

