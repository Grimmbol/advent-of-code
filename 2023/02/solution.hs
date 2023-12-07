import System.Environment (getArgs)
import StringUtils (splitLines)

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
        myFunction = findMostCaloricElf

findMostCaloricElf :: String -> String
findMostCaloricElf textInput =
  show mostCalories
  where
    mostCalories = maximum caloriesPerElf
    caloriesPerElf = sumCaloriesPerElf caloryLists
    caloryLists = createCaloryLists textInput 

createCaloryLists :: String -> [[Int]]
createCaloryLists textInput =
  createSublists $ splitLines textInput


createSublists :: [String] -> [[Int]]
createSublists textInputLines =
  createSublistsRecursive textInputLines []

createSublistsRecursive
  :: [String] -> [Int] -> [[Int]]

createSublistsRecursive [] subList =
  [subList]

createSublistsRecursive inputLines subList =
  let curElem =  head inputLines
  in
    if(curElem == "")
    then
      subList : createSublistsRecursive (tail inputLines) []
    else
      createSublistsRecursive (tail inputLines) $
      read curElem : subList

sumCaloriesPerElf :: [[Int]] -> [Int]
sumCaloriesPerElf caloryLists =
  map (\sublist -> sum sublist) caloryLists 


