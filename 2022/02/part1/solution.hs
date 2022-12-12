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
        myFunction = calculateScore

calculateScore :: String -> String
calculateScore inputString =
  show $
  sum $
  map calculateGameScore $
  map parseGame $
  splitLines inputString

type Game = (GameMove, GameMove)
data GameResult = Victory | Tie | Defeat
data GameMove = Rock | Paper | Scissors

calculateGameScore :: Game -> Int
calculateGameScore (opponentMove, myMove) =
  moveScore + gameResultScore
  where
    moveScore =
      case myMove of
        Rock -> 1
        Paper -> 2
        Scissors -> 3
    gameResultScore = getGameResultScore (opponentMove, myMove)

getGameResultScore :: Game -> Int
getGameResultScore (opponentMove, myMove) =
  case myMove of
    Rock -> case opponentMove of
      Scissors -> 6
      Rock -> 3
      Paper -> 0

    Paper -> case opponentMove of
      Rock -> 6
      Paper -> 3
      Scissors -> 0

    Scissors -> case opponentMove of
      Paper -> 6
      Scissors -> 3
      Rock -> 0



mapGameMove :: Char -> GameMove
mapGameMove moveChar =
  case moveChar of
    'A' -> Rock
    'B' -> Paper
    'C' -> Scissors
    'X' -> Rock
    'Y' -> Paper
    'Z' -> Scissors

parseGame :: String -> Game
parseGame (opponent:space:me:rest) =
  (mapGameMove opponent, mapGameMove me)

