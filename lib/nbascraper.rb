require 'open-uri'
require 'nokogiri'
require 'pry'
require 'json'

class Nbascraper

  def self.scrape_index(date)
    url = "http://data.nba.com/data/1h/json/cms/noseason/scoreboard/#{date}/games.json"
    doc = JSON.parse(Nokogiri::HTML(open(url)))  
    doc["sports_content"]["games"]["game"]
  end

end


