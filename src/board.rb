require "colorize"

class Board
  # Path is relative to where the program is run
  WORD_FILE = "resources/codename_words"
  # Width and height of board
  DIMENSION = 5
  # Number of newlines between rows
  PADDING = 2
  # Width of each column is longest word + SPACING
  SPACING = 5
  # Number of agents (not including the additional agent for the team that goes first)
  AGENTS = 8
  # Hash of roles and their associated colour
  ROLES = {
    assassin:  :yellow,
    bystander: :white,
    team_1:    :blue,
    team_2:    :red,
  }

  attr_reader :board, :agents

  class << self
    def convert_input(position)
      [(position - 1) / DIMENSION, (position - 1) % DIMENSION]
    end
  end

  def initialize(seed = nil)
    seed ||= Random.new_seed
    @rng = Random.new(seed)
    @words = load_words
    @board = generate_board
    @agents = generate_agents
    # Width of the longest word + SPACING
    @word_width = board.flatten.max_by(&:length).length + SPACING
    # Number of digits (ex: a 5 x 5 board's longest digit is a 2 digit number)
    @num_width = Math.log10(DIMENSION**2).to_i + 1

    @guessed = []
  end

  def guess(guess)
    @guessed << guess
  end

  # This is whack, need some kind of if block_given? in print_board
  def to_s
    print_board { |word| word }
  end

  protected

  def print_board
    board.map.with_index do |row, row_index|
      row.map.with_index(1) do |word, col_index|
        index = row_index * DIMENSION + col_index
        (index.to_s.rjust(@num_width) + '. ').light_black + yield(word.ljust(@word_width), index)
      end.join
    end.join("\n" * PADDING)
  end

  private

  def generate_board
    @words.sample(DIMENSION**2, random: @rng).map(&:chomp).each_slice(DIMENSION).to_a
  end

  def generate_agents
    # Create a hash, whose default value is bystander
    agents = Hash.new(:bystander)

    # Number of non bystander cards. 2 * AGENTS, +1 for team that goes first and +1 for assassin
    cards = AGENTS * 2 + 2

    [*1..DIMENSION**2].sample(cards, random: @rng).each_with_index do |position, index|
      agents[position] = index == cards - 1 ? :assassin : "team_#{index % 2 + 1}".to_sym
    end
    agents
  end

  def load_words
    File.readlines(WORD_FILE)
  end
end
