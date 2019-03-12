OPTIONS = [
  "Start a new game.",
  "Join an existing game.",
  "View instructions.",
]

puts "Welcome to codenames. What would you like to do?"
puts
OPTIONS.each_with_index { |prompt, i| puts "    #{i + 1}. #{prompt}" }
puts

begin
  print("Select an option: ")
  selection = Integer(gets) - 1
  raise if selection < 0 || selection >= OPTIONS.size
rescue
  puts "Please select a valid number between 1 and #{OPTIONS.size}."
  retry
end
puts "\nYour selection: #{OPTIONS[selection]}"

case selection
when 0
when 1
  puts "What is the game seed?"
  seed = gets.to_i
  puts "Join game as (a) field operative, or (b) spymaster?"
  choice = gets
  if choice == "a"
    board = FieldOperativeBoard.new(seed)
  elsif choice == "b"
    board = SpymasterBoard.new(seed)
  end
when 2
  puts "Not yet supported."
end

def prompt_int
  yield
  Integer(gets)
rescue
  puts "Please enter a valid integer."
  retry
end
