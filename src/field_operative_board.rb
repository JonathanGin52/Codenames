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
    print_board { |word, index| word.colorize(@guessed.include?(index) ? ROLES[agents[index]] : :white) }
  end
end
