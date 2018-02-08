main :: IO ()
main = do
    [n, m] <- words <$> getLine :: IO [String]
    let l = (read $ n++m)
    putStrLn $ if (length . snd . span (/= '.') . show $ sqrt l) == 2 then "Yes" else "No"
    -- print $ (length . snd . span (/= '.') . show $ sqrt l) == 2
    -- print $ (length . snd . span (/= '.') . show $ sqrt l) == 2

