require_relative "src/util"
require_relative "src/board"
require_relative "src/spymaster_board"
require_relative "src/field_operative_board"

board = menu

loop do
  puts board
  selection = prompt_int(error_text: "Please enter an integer between 1 and #{Board::DIMENSION**2}")
  board.guess(selection)
end
