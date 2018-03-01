main :: IO ()
main = print . toNum =<< getLine

toNum d = case d of
    "Sunday"    -> 0
    "Monday"    -> 5
    "Tuesday"   -> 4
    "Wednesday" -> 3
    "Thursday"  -> 2
    "Friday"    -> 1
    "Saturday"  -> 0
