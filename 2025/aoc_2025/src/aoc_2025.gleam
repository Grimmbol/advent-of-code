import gleam/string
import simplifile


pub fn main() {
  let file_read = simplifile.read("./src/01/test_input.txt")
  let input_lines = case file_read {
    Ok(contents) -> contents |> string.split("\n")
    _ -> []
  }
  echo input_lines
}
