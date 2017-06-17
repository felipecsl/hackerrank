-- https://www.hackerrank.com/challenges/find-strings
-- returns all the substrings of length l in xs
import Data.List (find)
import qualified Data.Set as Set
import Data.Maybe (isNothing, Maybe(..))

doSubstrings :: String -> Set.Set String
doSubstrings s = substrings (length s) s

substrings :: Int -> String -> Set.Set String
substrings _ [] = Set.singleton ""
substrings 0 _ = Set.singleton ""
substrings l (x:xs) = Set.union left right
  where left = Set.map ([x]++) inner
        right = substrings l xs
        inner = substrings (l - 1) xs

readStrings :: Int -> IO [String]
readStrings 0 = return []
readStrings n = do
  first <- getLine
  rest <- readStrings (n - 1)
  return (first : rest)

readListOfStrings :: IO [String]
readListOfStrings = fmap (read :: String -> Int) getLine >>= readStrings

readListOfInts :: IO [Int]
readListOfInts = fmap (map (read :: String -> Int)) readListOfStrings

doFilter :: [(String, Int)] -> Int -> Maybe String
doFilter strs q = fmap fst tuple
  where tuple = find (\(_, i) -> i == q) strs

printResults :: Maybe String -> IO ()
printResults x = do
  let actual = if isNothing x then Just "INVALID" else x
  mapM_ putStrLn actual

main :: IO ()
main = do
  -- print $ substrings 3 "aab"
  strings <- readListOfStrings
  queries <- readListOfInts
  -- putStrLn "Strings:"
  -- print strings
  -- putStrLn "Queries:"
  -- print queries
  let substrs = Set.toList $ foldMap id $ map (Set.deleteAt 0 . doSubstrings) strings
  -- putStrLn "Substrings:"
  -- print substrs
  let results = map (doFilter (zip substrs [1..])) queries
  mapM_ printResults results
  return ()
