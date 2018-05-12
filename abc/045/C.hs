main = print . sum . map (sum . map (read :: String -> Int) . words) . genTerm =<< getLine

genTerm :: String -> [String]
genTerm [s]    = [[s]]
genTerm (s:ss) = concat [map (\l->s:l) $ genTerm ss, map (\l->s:' ':l) $ genTerm ss]
