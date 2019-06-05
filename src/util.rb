module Util
  MENU_OPTIONS = [
    "Start a new game.",
    "Join an existing game.",
    "Read instructions.",
  ]

  def menu
    puts "Welcome to codenames. What would you like to do?"
    puts
    MENU_OPTIONS.each.with_index(1) { |prompt, i| puts "    #{i}. #{prompt}" }
    puts

    prompt_for_int("Select an option: ", error_text: "Please select a valid number between 1 and #{MENU_OPTIONS.size}.") do
    end
    begin
      selection = Integer(gets) - 1
      raise if selection < 0 || selection >= MENU_OPTIONS.size
    rescue
      puts "Please select a valid number between 1 and #{MENU_OPTIONS.size}."
      retry
    end
    puts "\nYour selection: #{MENU_OPTIONS[selection]}"

    case selection
    when 0
      puts "Your game seed is: #{rand(0..100000)}"
    when 1
      puts "What is the game seed?"
      seed = gets.to_i
      puts "Join game as (a) field operative, or (b) spymaster?"
      choice = gets
      if choice == "a"
        return FieldOperativeBoard.new(seed)
      elsif choice == "b"
        return SpymasterBoard.new(seed)
      end
    when 2
      puts "Not yet supported."
    end
  end

  def prompt_for_int(prompt, error_text: "")
    print(prompt)
    yield if block_given?
    Integer(gets)
  rescue
    puts error_text
    retry
  end
end
