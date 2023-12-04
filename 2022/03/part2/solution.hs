import System.Environment (getArgs)
import StringUtils (splitLines)
import Data.List (elem, nub)
import Data.Char (ord, isUpper)

-- From Real world haskell ch04
-- http://book.realworldhaskell.org/read/functional-programming.html
interactWith function inputFile outputFile = do
  input <- readFile inputFile
  writeFile outputFile (function input)

main = mainWith myFunction
  where mainWith function = do
          args <- getArgs
          case args of
            [input,output] -> interactWith function input output
            _ -> putStrLn "error: exactly two arguments needed"

        -- replace "id" with the name of our function below
        myFunction = printPrioritySum

        
type Rugsack = String


printPrioritySum :: String -> String
printPrioritySum inputLines =
  show $
  sum $
  map getPriorityOfCommonItemInTriplet $
  groupInTrees $
  splitLines inputLines

  where
    triplet =
      ["vJrwpWtwJgWrhcsFMMfFFhFp",
       "jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL",
       "PmmdzqPrVvPwwTWBwg"]


groupInTrees :: [Rugsack] -> [[Rugsack]]
groupInTrees [] =
  return []
groupInTrees (first:(second:(third:rest))) =
  [first, second, third] : (groupInTrees rest)


getPriorityOfCommonItemInTriplet :: [Rugsack] -> Int
getPriorityOfCommonItemInTriplet [] = 0
getPriorityOfCommonItemInTriplet (first:(second:(third:rest))) =
  mapCharToPriority $ head commonItems
  where
    commonItems =
      nub $ -- Remove duplicate matches
      findCommonItems first $
      findCommonItems second third
    


findCommonItems :: String -> String -> String
findCommonItems [] _ = []
findCommonItems _ [] = []
findCommonItems (curFirst:restFirst) second =
  let foundChar = findMatchingChar curFirst second
  in
    case foundChar of
      Just char -> char : (findCommonItems restFirst second)
      Nothing -> findCommonItems restFirst second

  where
    restSecond = tail second
  
findMatchingChar :: Char -> String -> Maybe Char
findMatchingChar _ [] = Nothing
findMatchingChar char (c:cs) =
  if(char == c)
  then
    Just char
  else
    findMatchingChar char cs

mapCharToPriority :: Char -> Int
mapCharToPriority char =
  if (isUpper char)
  then
    (ord char) - ord 'A' + 27
  else
    (ord char) - ord 'a' + 1
