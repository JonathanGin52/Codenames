require "colorize"
require_relative "board"

class FieldOperativeBoard < Board
  COLOUR_TABLE = {
    assassin:  :light_black,
    bystander: :white,
    team_1:    :blue,
    team_2:    :red,
  }

  def initialize
    super
    @guessed = []
  end

  def guess(guess)
    @guessed << guess
  end

  def to_s
    board.map.with_index do |row, row_index|
      row.map.with_index(1) do |word, col_index|
        position = row_index * DIMENSION + col_index
        colour = @guessed.include?(position) ? COLOUR_TABLE[agents[position]] : :white
        "#{position.to_s.rjust(2)}. #{word}".ljust(@width).public_send(colour)
      end.join
    end.join("\n" * PADDING)
  end
end
