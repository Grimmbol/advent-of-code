import gleam/string
import gleam/list
import gleam/int
import simplifile


pub fn main() {
  let file_read = simplifile.read("./src/01/full_input.txt")
  let input_lines = case file_read {
    Ok(contents) -> contents |> string.split("\n")
    _ -> []
  }
  echo input_lines
  let result = solve_01(input_lines)
  echo result
}


pub fn solve_01(input_lines: List(String)) -> Int {

  let positions = list.scan(over: input_lines, from: 50, with: get_new_position)

  echo positions
  
  list.fold(over: positions, from: 0, with: fn(zeroes, position) {
    case position_is_zero(position) {
      True -> zeroes + 1
      _ -> zeroes
    }
  })
}



pub type Command = String
pub type Position = Int

pub fn position_is_zero(position: Position) -> Bool {
   position % 100 == 0
}

pub fn get_new_position(position: Position, command: Command) -> Position {
  case parse_command(command) {
    #("L", length) -> {position - length}
    #("R", length) -> {position + length}
    #(_, _) -> {
      echo "????"
      position
    }
  }
}

pub fn parse_command(command: String) -> #(String, Int) {
  let direction = case string.first(command) {
    Ok(direction) -> direction
    _ -> ""
  }
  
  let length_string =  string.slice(command, 1, 2)
  let length = case int.parse(length_string) {
      Ok(length_as_int) -> length_as_int
      _ -> 0
    }
  #(direction, length)
}
