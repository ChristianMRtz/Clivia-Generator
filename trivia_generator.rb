require "json"
require "terminal-table"
require "httparty"
require_relative "presenter"
require_relative "requester"

class TriviaGenerator
  include HTTParty
  include Requester
  include Presenter

  base_uri "https://opentdb.com/"

  def initialize(file = ARGV)
    @counter = 0
    @counter_to_finish = 0
    @custom = ""
    @file = file
  end

  def start
    puts print_welcome
    action = select_main_menu_action
    until action == "exit "
      case action
      when "random" then random_trivia
      when "scores" then print_table_scores
      when "custom" then custom_option
      when "exit" then exit
      end
      action == select_main_menu_action
    end
  end

  def custom_option
    puts "select a category id (between 9 and 32)"
    print "> "
    category = $stdin.gets.chomp.to_i
    until category >= 9 && category <= 32
      puts "select a category id (between 9 and 32)"
      print "> "
      category = $stdin.gets.chomp.to_i
    end
    puts "select a difficulty (easy, medium or hard)"
    print "> "
    difficulty = $stdin.gets.chomp.strip
    until %w[easy medium hard].include?(difficulty)
      puts "select a difficulty (easy, medium or hard)"
      print "> "
      difficulty = $stdin.gets.chomp.strip
    end
    @custom = "&category=#{category}&difficulty=#{difficulty}"
    random_trivia
  end

  def data_of_api
    @data = self.class.get("/api.php?amount=10#{@custom}")
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
    input = $stdin.gets.chomp.strip.downcase
    until input == "n"
      case input
      when "y" then save
      else puts "Invalid option "
           print "Do you want to save your score? y/n "
           input = $stdin.gets.chomp.strip.downcase
      end
    end
    start
  end

  def save
    puts "Type the name to assign to the score"
    print "> "
    @input_name = $stdin.gets.chomp.strip
    @input_name.empty? ? @input_name = "Anonymous" : @input_name
    to_json
    start
  end

  def to_json(*_args)
    file = @file.empty? ? "score.json" : @file[0]
    File.exist?("score.json") ? file : File.open(file, "w")
    player_score = { name: @input_name, score: @counter }
    if File.read(file).empty?
      player_score = [{ name: @input_name, score: @counter }]
      File.write(file, player_score.to_json)
    else
      parsed = JSON.parse(File.read(file))
      parsed << player_score
      File.write(file, parsed.to_json)
    end
  end

  def print_table_scores
    file = @file.empty? ? "score.json" : @file[0]
    file == @file[0] ? File.open(file, "w") : file
    File.exist?(file) ? file : File.open(file, "w")
    if File.read(file).empty?
      puts print_score([{ "name" => "<Nobody>", "score" => 0 }])
    else
      parsed = JSON.parse(File.read(file))
      puts print_score(parsed)
    end
    start
  end
end

trivia = TriviaGenerator.new
trivia.start
