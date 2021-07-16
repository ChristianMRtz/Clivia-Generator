require_relative "presenter"
require_relative "requester"
require_relative "questions"
# do not forget to require your gem dependencies
# do not forget to require_relative your local dependencies

class TriviaGenerator
  include Requester
  include Presenter
  # maybe we need to include a couple of modules?

  def initialize
    @counter = 0
    @counter_to_finish = 0
    # we need to initialize a couple of properties here
  end

  def start
    puts print_welcome
    action = select_main_menu_action
    until action == "exit"
      case action
      when "random" then random_trivia
      when "scores" then puts "scoreeeees"
      end
      action = select_main_menu_action
    end
  end

  def random_trivia
    print "loading..."
    response = QuestionsData.data_of_api
    10.times { ask_question(response.parsed_response) }
    @counter_to_finish == 10 ? game_over : ""
  end

  def answer(question, input, shuffle_answers)
    correct_answer = @coder.decode(question["correct_answer"])
    if correct_answer == shuffle_answers[input - 1]
      puts "#{shuffle_answers[input - 1]}... Correct!"
      @counter += 10
    else
      puts "#{shuffle_answers[input - 1]}... Incorrect!"
      puts "The correct answer was: #{correct_answer} "
    end
    @counter_to_finish += 1
  end

  def game_over
    puts "Well done! Your score is #{@counter}"
    puts "-" * 50
    print "Do you want to save your score? y/n "
    input = gets.chomp.strip.downcase
    until input == "n"
      case input
      when "y" then save
      else puts "Invalid option "
           print "Do you want to save your score? y/n "
           input = gets.chomp.strip.downcase
      end
    end
  end

  def ask_questions
    # ask each question
    # if response is correct, put a correct message and increase score
    # if response is incorrect, put an incorrect message, and which was the correct answer
    # once the questions end, show user's score and promp to save it
  end

  def save
    puts "Type the name to assign to the score"
    print "> "
    input = gets.chomp.strip
    puts input # FOR THE FILE OF JSONNNNNNNNNNNNNNNNNNNN
    start
  end

  def parse_scores
    # get the scores data from file
  end

  def load_questions
    # ask the api for a random set of questions
  end

  def parse_questions
    # questions came with an unexpected structure, clean them to make it usable for our purposes
  end

  def print_scores
    # print the scores sorted from top to bottom
  end
end

trivia = TriviaGenerator.new
trivia.start
