module Lib (main) where

import Data.List (intercalate)

perform :: [String] -> IO ()
perform [] = return ()
perform [_] = return ()
perform (_:p:_) = do
  line <- getLine
  let pNum = read p :: Int
  let arr = words line
  let prefix = drop pNum arr
  let suffix = take pNum arr
  let result = prefix ++ suffix
  putStrLn $ intercalate " " result


main :: IO ()
main = getLine >>= return . words >>= perform