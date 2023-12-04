import sys
import re

DIGIT_WORDS = {
    "one": 1,
    "two": 2,
    "three": 3,
    "four": 4,
    "five": 5,
    "six": 6,
    "seven": 7,
    "eight": 8,
    "nine": 9
}

class Digit():
    def __init__(self, value, position):
        self.value = value
        self.position = position

    def __str__(self):
        return ("value: " + str(self.value) +
                ", position: " + str(self.position))

def is_integer(v):
    try:
        f=int(v)
    except ValueError:
        return False
    return True

def find_digit_numerals_in_line(line):
    digits_found = []
    cur_position = 0
    for char in line:
        if(is_integer(char)):
            digits_found.append(
                Digit(
                    int(char),
                    cur_position
                )
            )
        cur_position = cur_position + 1

    return digits_found
        

def find_digit_words_in_line(line):
    digits_found = []
    for digit_word in DIGIT_WORDS:
        digit_word_value = DIGIT_WORDS[digit_word]
        matches = re.finditer(digit_word, line)
        for match in matches:
            digits_found.append(
                Digit(
                    digit_word_value,
                    match.start()
                )
            )
    return digits_found

def get_digits(line):
    return (
        find_digit_numerals_in_line(line) +
        find_digit_words_in_line(line)
    )
    

def get_value_for_line(line):
    digits = get_digits(line)
    digits_sorted_by_position = sorted(
        digits,
        key = lambda digit: digit.position
    )

    first_digit = digits_sorted_by_position[0]
    last_digit = digits_sorted_by_position[len(digits) - 1]
    result_number = first_digit.value * 10 + last_digit.value
    
    #print(first_digit, "+", last_digit, "=", result_number )
    
    return result_number
    

def main():
    input_file_name = sys.argv[1]
    input_file = open(input_file_name)
    accumulated_result = 0
    for line in input_file:
        accumulated_result = accumulated_result + get_value_for_line(line)
    

    print(accumulated_result)

main()
