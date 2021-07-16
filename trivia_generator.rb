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
    # we need to initialize a couple of properties here
  end

  def start
    puts print_welcome
    menu
  end

  def menu
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
    ask_question(response.parsed_response)
  end

  def ask_questions
    # ask each question
    # if response is correct, put a correct message and increase score
    # if response is incorrect, put an incorrect message, and which was the correct answer
    # once the questions end, show user's score and promp to save it
  end

  def save(data)
    # write to file the scores data
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
