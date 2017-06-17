foo :: Int -> [Int] -> [Int]
foo _ [] = []
foo i (x:xs) =
  if i `mod` 2 == 0
    then foo (i + 1) xs
    else x : foo (i + 1) xs

f :: [Int] -> [Int]
f lst = foo 0 lst

-- This part deals with the Input and Output and can be used as it is. Do not modify it.
main = do
   inputdata <- getContents
   mapM_ (putStrLn. show) . f . map read . lines $ inputdata
