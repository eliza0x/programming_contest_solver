import qualified Control.Monad as C
import qualified Data.List     as L
import qualified Data.Array.IO as A

main = do
    arr <- A.newArray (1, 10) 0 :: IO (A.IOArray Int Int)
    a   <- A.readArray arr 1
    A.writeArray arr 1 64
    b   <- A.readArray arr 1
    print (a, b)

