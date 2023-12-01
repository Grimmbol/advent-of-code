import sys

def is_integer(v):
    try:
        f=int(v)
    except ValueError:
        return False
    return True


def get_value_for_line(line):
    first_digit = None
    last_digit = None

    for char in line:
        if(is_integer(char)):
            first_digit = char
            break

    for char in reversed(line):
        if(is_integer(char)):
            last_digit = char
            break

    return int(first_digit + last_digit)

def main():
    input_file_name = sys.argv[1]
    input_file = open(input_file_name)
    accumulated_result = 0
    for line in input_file:
        accumulated_result = accumulated_result + get_value_for_line(line)
    

    print(accumulated_result)
main()
