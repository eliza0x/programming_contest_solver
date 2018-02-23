import Data.List

main = do
    s' <- getLine
    t  <- getLine
    let s = restore (reverse s') (reverse t)
    putStrLn $ if canRestore s' t 
        then reverse $ map (\c->if c=='?' then 'a' else c) s
        else "UNRESTORABLE"

restore s' t = let
    s = restore' s' t
    in if s == s' then s 
                  else restore s t

canRestore [] _ = False
canRestore (s:ss) key = canReplace (s:ss) key || canRestore ss key

restore' [] _ = []
restore' s' t = if canReplace s' t 
 then t ++ drop (length t) s'
 else head s' : restore' (tail s') t
 
canReplace _ [] = True
canReplace [] _ = False
canReplace (x:xs) (y:ys) = (x=='?' || y=='?' || x==y) && canReplace xs ys
    
