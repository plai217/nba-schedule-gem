require 'open-uri'
require 'nokogiri'
require 'pry'
require 'json'

class Nbascraper

  attr_reader :data, :schedule, :scores, :player, :game_urls

  def self.today
    puts "*****Today's games*****"
    date = Time.now.strftime("%Y%m%d")
    get_data(date)
    show_schedule_scores
    puts "***********************"
  end

  def self.get_games(date)
    puts "*****Schedule and scores for #{date}*****"
    get_data(date)
    show_schedule_scores
    puts "******************************************"
  end

  def self.get_summary
    @game_urls.each_with_index {|game,i| puts "#{i+1}. #{game}"} 
    game_number = 0
    until game_number.between?(1,(@game_urls.size)) 
      puts "Please enter 1 - #{@game_urls.size}"
      game_number = gets.strip.to_i
    end
    scrape_summary(@game_urls[game_number-1])
  end

  def self.get_data(date)
    @data = scrape_index(date)
    @game_urls = []
    @data.each {|game| @game_urls << game["game_url"]}
  end

  def self.show_schedule_scores
    @data.each do |game|
        puts game_score(game["id"])
    end
  end

  def self.game_score(id)
    @data.each do |game| 
      return "#{game["visitor"]["nickname"]} - #{game["visitor"]["score"]} #{game["home"]["nickname"]} - #{game["home"]["score"]} #{game["period_time"]["period_status"]}" if game["id"] == id
    end
  end

  def self.scrape_index(date)
    url = "http://data.nba.com/data/1h/json/cms/noseason/scoreboard/#{date}/games.json"
    doc = JSON.parse(Nokogiri::HTML(open(url)))  
    doc["sports_content"]["games"]["game"]
  end

  def self.scrape_summary(game_url)
    url = "http://www.nba.com/games/#{game_url}/gameinfo.html?ls=iref:nba:scoreboard"
    doc = Nokogiri::HTML(open(url))
    puts "****************************************"
    if doc.css("#nbaGIRecap2 p").text == ""
      puts doc.css("#nbaGIPreview p").text
    else
      puts doc.css("#nbaGIRecap2 p").text
    end
    puts "****************************************"
  end

end

