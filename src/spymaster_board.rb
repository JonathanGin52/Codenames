require_relative "board"

class SpymasterBoard < Board
  def to_s
    print_board { |word, index| word.colorize(ROLES[agents[index]]) }
  end
end
