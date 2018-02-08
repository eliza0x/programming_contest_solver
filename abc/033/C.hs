main :: IO ()
main = print . length . filter (\c -> c /= '+' && c /= '0') . shrincMul =<< getLine

shrincMul :: String -> String
shrincMul  []           = ""
shrincMul  [n]          = [n]
shrincMul  (x:op:y:str) = case (x , op, y) of
    (n, '+', m    ) -> n:'+':shrincMul (m:str)
    ('0', '*', _  ) -> shrincMul ('0':str)
    (_  , '*', '0') -> shrincMul ('0':str)
    (_  , '*', n  ) -> shrincMul (n:str)
    _               -> error [x,op,y]
