require "httparty"
class QuestionsData
  include HTTParty
  base_uri "https://opentdb.com/"

  def self.data_of_api
    @data = get("/api.php?amount=10")
  end
end
