import System.Environment (getArgs)
import StringUtils (splitLines)
import Data.List (sort, elem)
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
  --sum $
  findCommonItems "abc" "bdc"
  
  --map getPriorityOfCommonItemInTriplet $
  --groupInTrees $
  --splitLines inputLines


groupInTrees :: [Rugsack] -> [[Rugsack]]
groupInTrees [] =
  return []
groupInTrees (first:(second:(third:rest))) =
  [first, second, third] : (groupInTrees rest)


getPriorityOfCommonItemInTriplet:: [Rugsack] -> Int
getPriorityOfCommonItemInTriplet [] = 0
getPriorityOfCommonItemInTriplet list =
  mapCharToPriority (commonItems !! 0)
  where
    commonItems =
      findCommonItems first $ findCommonItems second third
    (first:(second:(third:rest))) =
      list


findCommonItems :: String -> String -> String
findCommonItems [] _ = []
findCommonItems _ [] = []
findCommonItems (curFirst:restFirst) (curSecond:restSecond) =
  if(curFirst == curSecond)
  then
    curFirst : (findCommonItems restFirst restSecond)
  else
    (findCommonItems restFirst restSecond)

mapCharToPriority :: Char -> Int
mapCharToPriority char =
  if (isUpper char)
  then
    (ord char) - ord 'A' + 27
  else
    (ord char) - ord 'a' + 1
