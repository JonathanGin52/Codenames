class Board
  # Path is relative to where the program is run
  WORD_FILE = "resources/codename_words"

  attr_reader :board

  def initialize(seed = nil)
    seed ||= Random.new_seed
    @rng = Random.new(seed)
    @board = generate_board
    @width = @board.flatten.max_by(&:length).length + 2
  end

  def generate_board
    words.sample(25, random: @rng).each_slice(5).to_a
  end

  def words
    return @words unless @words.nil?
    @words = []
    File.open(WORD_FILE, "r") do |file|
      file.each_line do |word|
        @words << word.chomp
      end
    end
    @words
  end

  def to_s
    output = ""
    @board.each { |row| output += "#{row.map { |word| word.rjust(@width) }.join}\n" }
    #aoeuaeua
    output
  end
end

b = Board.new
puts b
