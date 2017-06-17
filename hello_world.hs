import Control.Applicative
import Control.Monad
import System.IO

main :: IO ()
main = do
    n_temp <- getLine
    let n = read n_temp :: Int
    doit [0..n - 1]

doit :: [Int] -> IO ()
doit [] = return ()
doit (_:xs) = do
  putStrLn "Hello World"
  doit xs

getMultipleLines :: Int -> IO [String]

getMultipleLines n
    | n <= 0 = return []
    | otherwise = do
        x <- getLine
        xs <- getMultipleLines (n-1)
        let ret = (x:xs)
        return ret
