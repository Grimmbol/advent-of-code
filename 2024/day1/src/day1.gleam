import gleam/io
import gleam/string
import gleam/list
import simplifile

pub fn main() {
  let test_file_path = "./src/input_test.txt"
  let file_lookup = simplifile.read(from: test_file_path)
  case file_lookup {
    Ok(content) -> do_task(content)
    Error(file_error) ->
      io.println(
        "Could not load from file: " <> simplifile.describe_error(file_error),
      )
  }
}

fn do_task(file_contents: String) {
  io.println("Hello from day1!")
  let input_data = parse_input_data(file_contents)
  
}

fn parse_input_data(input_file_content: String) {
  string.split(input_file_content, "\n")
  |> list.map(fn(s) {string.split(s, "   ")})
}
