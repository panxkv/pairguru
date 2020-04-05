require "rest-client"
require "json"

class MovieImporter < ApplicationService
  BASE_URL = "https://pairguru-api.herokuapp.com/api/v1/movies/".freeze

  def initialize(title)
    @title = title
  end

  def call
    fetch_data(@title)
  end

  def movie_url(title)
    BASE_URL + title.gsub(" ", "%20")
  end

  def fetch_data(title)
    url = movie_url(title)
    response = RestClient.get url
    OpenStruct.new(JSON.parse(response)["data"]["attributes"])
  rescue RestClient::ExceptionWithResponse
  end
end
