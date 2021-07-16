require "terminal-table"
module Presenter
  def print_welcome
    message = ["###################################",
               "#   Welcome to Trivia Generator   #",
               "###################################"]
    message.join("\n")
  end

  def print_score(score)
    table = Terminal::Table.new
    table.title = "Top Scores"
    table.headings = %w[Name Score]
    table.rows = sort_by_score(score).map do |i|
      [i["name"], i["score"]]
    end
    table
  end

  def sort_by_score(scores)
    scores.sort_by { |k| k[:score] }.reverse
  end
end
