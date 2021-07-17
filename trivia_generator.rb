require "json"
require "terminal-table"
require "httparty"
require_relative "presenter"
require_relative "requester"

# do not forget to require your gem dependencies
# do not forget to require_relative your local dependencies

class TriviaGenerator
  include HTTParty
  include Requester
  include Presenter

  base_uri "https://opentdb.com/"
  # maybe we need to include a couple of modules?

  def initialize
    @counter = 0
    @counter_to_finish = 0
    @id = 0
    # we need to initialize a couple of properties here
  end

  def start
    puts print_welcome
    action = select_main_menu_action
    until action == "exit"
      case action
      when "random" then random_trivia
      when "scores" then print_table_scores
      end
      action == exit ? exit : select_main_menu_action
    end
  end

  def data_of_api
    @data = self.class.get("/api.php?amount=10")
  end

  def random_trivia
    print "loading..."
    response = data_of_api
    ask_question(response.parsed_response)
    @counter_to_finish == 10 ? game_over : random_trivia
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
    @counter_to_finish = 0
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

  def save
    puts "Type the name to assign to the score"
    print "> "
    @input_name = gets.chomp.strip
    @id += 1
    to_json
    start
  end

  def to_json(*_args)
    player_score = {
      name: @input_name,
      score: @counter
    }
    parsed = JSON.parse(File.read("score.json"))
    parsed["player"] << player_score
    File.write("score.json", parsed.to_json)
  end

  def print_table_scores
    parsed = JSON.parse(File.read("score.json"))
    puts print_score(parsed["player"])
    start
  end
end

trivia = TriviaGenerator.new
trivia.start
