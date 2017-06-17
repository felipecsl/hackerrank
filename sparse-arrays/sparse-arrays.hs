-- https://www.hackerrank.com/challenges/sparse-arrays
import qualified Data.Map.Strict as Map

readStrings :: Int -> IO [String]
readStrings 0 = return []
readStrings n = do
  first <- getLine
  rest <- readStrings (n - 1)
  return (first : rest)

readListOfStrings :: IO [String]
readListOfStrings = fmap (read :: String -> Int) getLine >>= readStrings

populateMap :: [String] -> Map.Map String Integer -> Map.Map String Integer
populateMap [] freq = freq
populateMap (x:xs) freq = populateMap xs (rest existing)
  where rest Nothing  = Map.union freq (Map.singleton x 1)
        rest (Just y) = Map.insert x (y + 1) freq
        existing = Map.lookup x freq

main :: IO ()
main = do
  strings <- readListOfStrings
  queries <- readListOfStrings
  let occurences = populateMap strings Map.empty
  _ <- traverse (\x -> case Map.lookup x occurences of
                    Nothing -> putStrLn "0"
                    Just y  -> print y) queries
  return ()
