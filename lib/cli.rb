require_relative "../lib/nbascraper.rb"
require 'nokogiri'
require 'pry'
require 'open-uri'

class Nbascraper::CLI

  attr_reader :data, :schedule, :scores

  def start
    today
    list
  end

  def list
    selection = ""
    until selection == "5"
      puts "Enter 1 to refresh today's scores"
      puts "Enter 2 to see schedules and scores for another date"
      puts "Enter 5 to exit"
      selection = gets.strip
      case selection
      when "1"
        today
      when "2"
        new_date
      when "3"
        puts "Place Holder"
      when "5"
        puts "Good-bye"
      else
        puts "Invalid selection."
      end 
    end    
  end

  def today
    puts "Today's games"
    date = Time.now.strftime("%Y%m%d")
    get_data(date)
    show_schedule_scores
  end

  def new_date
    puts "Please enter year in YYYY format"
    year = gets.strip
    puts "Please enter month in MM format"
    month = gets.strip
    puts "Please enter day of month in DD format"
    day = gets.strip
    date = "#{year}#{month}#{day}"
    get_data(date)
    show_schedule_scores
  end

  def get_data(date)
    @data = Nbascraper.scrape_index(date)
  end

  def get_schedule
    @schedule = {}
    @data.each do |game|
      @schedule[game["id"]] = "#{game["visitor"]["nickname"]} at #{game["home"]["nickname"]} starting #{game["time"]}"    
    end
    @schedule
  end

  def get_scores
    @scores = {}
    @data.each do |game|
      @scores[game["id"]] = "#{game["visitor"]["nickname"]} - #{game["visitor"]["score"]} #{game["home"]["nickname"]} - #{game["home"]["score"]}"    
    end 
    @scores   
  end

  def game_score(id)
    @data.each do |game| 
      return "#{game["visitor"]["nickname"]} - #{game["visitor"]["score"]} #{game["home"]["nickname"]} - #{game["home"]["score"]}" if game["id"] == id
    end
  end

  def game_start(id)
    @data.each do |game| 
      return "#{game["visitor"]["nickname"]} at #{game["home"]["nickname"]} game starts #{game["time"]}" if game["id"] == id
    end
  end

  def show_schedule_scores
    @data.each do |game|
      if game["visitor"]["score"] == ""
        puts game_start(game["id"])
      else
        puts game_score(game["id"])
      end
    end
  end

end
