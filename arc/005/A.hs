main :: IO () 
main = do
    n <- read <$> getLine :: IO Int
    tc <- length . filter (\w->w=="TAKAHASHIKUN" || w=="Takahashikun" || w=="takahashikun")
            . words . init <$> getLine 
    print tc
