require "htmlentities"

module Requester
  def select_main_menu_action
    @options = %w[random custom scores exit]
    puts @options.join(" | ")
    print "> "
    input = $stdin.gets.chomp.strip.downcase
    until @options.include? input
      puts "invalid option"
      puts @options.join(" | ")
      print "> "
      input = $stdin.gets.chomp.strip.downcase
    end
    input
  end

  def valid_menu_option(action)
    until @options.include? action
      puts "invalid option"
      action = select_main_menu_action
    end
  end

  def ask_question(question)
    @coder = HTMLEntities.new
    questionrand = question["results"].sample
    print "\rCategory: #{questionrand['category']}#{'' * 10}"
    puts "#{'' * 10} | Difficulty: #{questionrand['difficulty']}"
    puts "Question: #{@coder.decode(questionrand['question'])}"
    questionrand["type"] == "multiple" ? if_multiple(questionrand) : if_boolean(questionrand)
  end

  def if_boolean(question)
    array_to_string = question["incorrect_answers"].join(", ")
    all_answers = array_to_string + ", #{question['correct_answer']}"
    shuffle_answers = @coder.decode(all_answers).split(", ").shuffle
    puts "1. #{shuffle_answers[0]}"
    puts "2. #{shuffle_answers[1]}"
    print "> "
    input = $stdin.gets.chomp.to_i
    answer(question, input, shuffle_answers)
  end

  def if_multiple(question)
    array_to_string = question["incorrect_answers"].join(", ")
    all_answers = array_to_string + ", #{question['correct_answer']}"
    shuffle_answers = @coder.decode(all_answers).split(", ").shuffle
    puts "1. #{shuffle_answers[0]}"
    puts "2. #{shuffle_answers[1]}"
    puts "3. #{shuffle_answers[2]}"
    puts "4. #{shuffle_answers[3]}"
    print "> "
    input = $stdin.gets.chomp.to_i
    answer(question, input, shuffle_answers)
  end
end
