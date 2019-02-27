require "colorize"
require_relative "board"

class FieldOperativeBoard < Board
  def initialize
    super
    @guessed = []
  end

  def guess(guess)
    @guessed << guess
  end

  def to_s
    print_board do |word, row_index, col_index|
      position = row_index * DIMENSION + col_index
      colour = @guessed.include?(position) ? COLOUR_TABLE[agents[position]] : :white
      "#{position.to_s.rjust(2)}. #{word}".ljust(@width).public_send(colour)
    end
  end
end
