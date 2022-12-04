import System.Environment (getArgs)
import StringUtils (splitLines)
import Data.List (sort)

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
        myFunction = findTopThreeCaloricElves


findTopThreeCaloricElves :: String -> String
findTopThreeCaloricElves textInput =
  show $ sumTopThree caloriesPerElf
  where
    caloriesPerElf = map (\elfInventory -> sum elfInventory) caloryList
    caloryList = createCaloryList $ splitLines textInput

sumTopThree :: [Int] -> Int
sumTopThree [] = 0
sumTopThree list =
  sum topThree
  where
    topThree = take 3 $ reverse sortedList
    sortedList = sort list

createCaloryList :: [String] -> [[Int]]
createCaloryList inputLines =
  createCaloryListRecursive inputLines []

createCaloryListRecursive :: [String] -> [Int] -> [[Int]]
createCaloryListRecursive [] subList =
  [subList]

createCaloryListRecursive (curString:rest) subList =
  if(curString == "")
  then
    subList : createCaloryListRecursive rest []
  else
    createCaloryListRecursive rest ((read curString):subList)

    
