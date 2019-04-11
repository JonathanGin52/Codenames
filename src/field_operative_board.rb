require_relative "board"

class FieldOperativeBoard < Board
  def to_s
    print_board { |word, index| word.colorize(@guessed.include?(index) ? ROLES[agents[index]] : :white) }
  end
end
