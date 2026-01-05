import gleam/string
import gleam/list
import gleam/int
import simplifile


pub fn main() {
  let file_read = simplifile.read("./src/01/test_input.txt")
  let input_lines = case file_read {
    Ok(contents) -> contents |> string.split("\n")
    _ -> []
  }
  echo input_lines
  let result = solve_01(input_lines)
  echo result
}


pub fn solve_01(input_lines: List(String)) -> Int {
  let initial_state = IterationState(50, 0)

  initial_state.zeroes
}


pub type Command = String
pub type Position = Int

pub type IterationState {
  IterationState(position: Position, zeroes: Int)
}

pub fn update_state(state: IterationState, command: Command) -> IterationState {  
  let new_position = get_new_position(state.position, command)
  
  let zeroes = state.zeroes + case { new_position % 100 }  {
    0 -> state.zeroes + 1
    _ -> state.zeroes
  }

  IterationState(new_position, zeroes)
}

pub fn get_new_position(position: Position, command: Command) -> Position {
  case parse_command(command) {
    #("L", length) -> {position - length}
    #("R", length) -> {position + length}
    #(_, _) -> {position}
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
