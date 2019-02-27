class Board
  # Path is relative to where the program is run
  WORD_FILE = "resources/codename_words"
  # Width and height of board
  DIMENSION = 5
  # Number of newlines between rows
  PADDING = 2
  # Width of each column is longest word + SPACING
  SPACING = 2

  attr_reader :board

  def initialize(seed = nil)
    seed ||= Random.new_seed
    @rng = Random.new(seed)
    @board = generate_board
    @width = @board.flatten.max_by(&:length).length + SPACING
  end

  def generate_board
    words.sample(DIMENSION**2, random: @rng).each_slice(DIMENSION).to_a
  end

  def words
    @words ||= File.readlines(WORD_FILE).map(&:chomp)
  end

  def to_s
    @board.map { |row| row.map { |word| word.rjust(@width) }.join }.join("\n" * PADDING)
  end
end
