require "htmlentities"
module Requester
  def select_main_menu_action
    @options = %w[random scores exit]
    puts @options.join(" | ")
    print "> "
    input = gets.chomp.strip.downcase
    until @options.include? input
      puts "invalid option"
      puts @options.join(" | ")
      print "> "
      input = gets.chomp.strip.downcase
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
    # show category and difficulty from question
    # show the question
    # show each one of the options
    # grab user input
  end

  def if_boolean(question)
    array_to_string = question["incorrect_answers"].join(", ")
    all_answers = @coder.decode(array_to_string) + ", #{question['correct_answer']}"
    shuffle_answers = all_answers.split(", ").shuffle
    puts "1. #{shuffle_answers[0]}"
    puts "2. #{shuffle_answers[1]}"
  end

  def if_multiple(question)
    array_to_string = question["incorrect_answers"].join(", ")
    all_answers = @coder.decode(array_to_string) + ", #{question['correct_answer']}"
    shuffle_answers = all_answers.split(", ").shuffle
    puts "1. #{shuffle_answers[0]}"
    puts "2. #{shuffle_answers[1]}"
    puts "3. #{shuffle_answers[2]}"
    puts "4. #{shuffle_answers[3]}"
  end

  def will_save?(score)
    # show user's score
    # ask the user to save the score
    # grab user input
    # prompt the user to give the score a name if there is no name given, set it as Anonymous
  end

  def get_number(max: 100_000)
    # prompt the user for a number between 1 and the maximum number of options
  end

  def gets_option(prompt, options)
    # prompt for an input
    # keep going until the user gives a valid option
  end
end
