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
        myFunction = getResultOfCorrectPlay

-- For all pairs, create the requested game result

data GameResult = Win | Tie | Lose
data GameMove = Rock | Paper | Scissors
data GamePlan = GamePlan GameMove GameResult
data Game = Game GameMove GameMove

showGame :: Game -> String
showGame (Game opponentMove myMove) =
  (showGameMove opponentMove) ++ ", " ++ (showGameMove myMove)

showGameMove :: GameMove -> String
showGameMove move =
  case move of
    Rock -> "rock"
    Paper -> "paper"
    Scissors -> "scissors"

getResultOfCorrectPlay :: String -> String
getResultOfCorrectPlay inputString =
  show $
  sum $
  map calculateGameScore $
  map solveGamePlan $
  map mapGamePlan $
  splitLines inputString


solveGamePlan :: GamePlan -> Game
solveGamePlan (GamePlan opponentMove desiredResult) =
  Game opponentMove myMove
  where
    myMove = findCorrectMove opponentMove desiredResult

findCorrectMove :: GameMove -> GameResult -> GameMove
findCorrectMove opponentMove desiredResult =
  case desiredResult of
    Tie -> opponentMove
    Win -> case opponentMove of
      Rock -> Paper
      Paper -> Scissors
      Scissors -> Rock
    Lose -> case opponentMove of
      Rock -> Scissors
      Paper -> Rock
      Scissors -> Paper

mapGamePlan :: String -> GamePlan
mapGamePlan (opponentMove:space:desiredResult:rest) =
  GamePlan (mapGameMove opponentMove) (mapGameResult desiredResult)


mapGameMove :: Char -> GameMove
mapGameMove moveChar =
  case moveChar of
    'A' -> Rock
    'B' -> Paper
    'C' -> Scissors
    'X' -> Rock
    'Y' -> Paper
    'Z' -> Scissors

mapGameResult :: Char -> GameResult
mapGameResult char =
  case char of
    'X' -> Lose
    'Y' -> Tie
    'Z' -> Win

calculateGameScore :: Game -> Int
calculateGameScore (Game opponentMove myMove) =
  moveScore + gameResultScore
  where
    moveScore =
      case myMove of
        Rock -> 1
        Paper -> 2
        Scissors -> 3
    gameResultScore =
      getGameResultScore (Game opponentMove myMove)

getGameResultScore :: Game -> Int
getGameResultScore (Game opponentMove myMove) =
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


