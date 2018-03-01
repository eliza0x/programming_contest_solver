main = print . (\[h,b]->b*h*h/10000.0) . map (read :: String -> Double) . words =<< getLine
