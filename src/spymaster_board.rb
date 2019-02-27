require "colorize"
require_relative "board"

class SpymasterBoard < Board
  def to_s
    print_board do |word, row_index, col_index|
      position = row_index * DIMENSION + col_index
      colour = COLOUR_TABLE[agents[position]]
      "#{position.to_s.rjust(2)}. #{word}".ljust(@width).colorize(colour)
    end
  end
end
