import sys


def get_value_for_line(line):
    first_digit = None
    last_digit = None
    
    

def main():
    input_file_name = sys.argv[1]
    input_file = open(input_file_name)
    accumulated_result = 0
    for line in input_file:
        accumulated_result = accumulated_result + get_value_for_line(line)
