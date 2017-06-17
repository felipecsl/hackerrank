-- https://www.hackerrank.com/challenges/sherlock-and-anagrams
import Data.List (sort, nub)
import Data.Map.Strict (Map, fromListWith, elems)

readStrings :: Int -> IO [String]
readStrings 0 = return []
readStrings n = do
  first <- getLine
  rest <- readStrings (n - 1)
  return (first : rest)

readListOfStrings :: IO [String]
readListOfStrings = fmap (read :: String -> Int) getLine >>= readStrings

findSubstrings :: String -> [String]
findSubstrings str = findSubstrings' str 0 0

sortAndGroup :: Ord k => [(k,a)] -> Map k [a]
sortAndGroup assocs = fromListWith (++) [(k, [v]) | (k, v) <- assocs]

-- Takes a string, start and end indices, returns a list of all the substrings in that range
findSubstrings' :: String -> Int -> Int -> [String]
findSubstrings' [] _ _ = []
findSubstrings' str start end
  | start > end = []
  | start > lngth = []
  | end > lngth = []
  | otherwise = if lngth /= length (nub str) then first ++ rest else []
  where substr s e = take (e - s + 1) (drop s str)
        lngth = length str
        first = [substr x y | x <- [start], y <- [end..lngth - 1]]
        rest = findSubstrings' str (start + 1) (end + 1)

findAnagrams :: [String] -> Int
findAnagrams [] = 0
findAnagrams (x:xs) = allAnagrams x xs + findAnagrams xs
  where allAnagrams b bs = length [i | i <- [b], j <- bs, length i == length j, sort i == sort j]

main :: IO ()
main = do
  strings <- readListOfStrings
  let substrs = map findSubstrings strings
  -- group substrings by their sizes
  let sizeGroups = map (elems . sortAndGroup . map (\x -> (length x, x))) substrs
  mapM_ (print . sum . map findAnagrams) sizeGroups
  return ()
