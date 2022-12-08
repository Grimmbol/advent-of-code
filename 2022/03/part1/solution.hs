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

        
data Rugsack = Rugsack Compartment Compartment
type Compartment = String


printPrioritySum :: String -> String
printPrioritySum inputLines =
  show $
  sum $
  map getPriorityOfMisplacedItem $
  map fillRugsack $
  splitLines inputLines


getPriorityOfMisplacedItem :: Rugsack -> Int
getPriorityOfMisplacedItem (Rugsack first second) =
  mapCharToPriority $
  findEqualItem first second

findEqualItem :: Compartment -> Compartment -> Char
findEqualItem first second =
  findEqualItemRecursive first second

findEqualItemRecursive :: Compartment -> Compartment -> Char
findEqualItemRecursive (cur:rest) otherList =
  if(elem cur otherList)
  then
    cur
  else
    findEqualItemRecursive rest otherList

mapCharToPriority :: Char -> Int
mapCharToPriority char =
  if (isUpper char)
  then
    (ord char) - ord 'A' + 27
  else
    (ord char) - ord 'a' + 1

fillRugsack :: String -> Rugsack
fillRugsack inputString =
  Rugsack firstCompartment secondCompartment
  where
    (firstCompartment, secondCompartment) = 
      splitAt midpoint inputString

    midpoint = (length inputString) `div` 2


showRugsack :: Rugsack -> String
showRugsack (Rugsack first second) =
  first ++ ", " ++ second
