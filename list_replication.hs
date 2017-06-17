-- https://www.hackerrank.com/challenges/fp-list-replication?h_r=next-challenge&h_v=zen
f :: Int -> [Int] -> [Int]
f _ [] = []
f n (x:xs) = map (const x) [0..n - 1] ++ f n xs

-- This part handles the Input and Output and can be used as it is. Do not modify this part.
main :: IO ()
main = getContents >>= mapM_ print . (\(n:arr) -> f n arr). map read . words
