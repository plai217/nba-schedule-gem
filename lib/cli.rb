require_relative "../lib/nbascraper.rb"
require 'pry'

class Nbascraper::CLI

  def start
    Nbascraper.today
    list
  end

  def list
    selection = ""
    until selection == "5"
      puts "Enter 1 to refresh today's scores"
      puts "Enter 2 to see schedules and scores for another date"
      puts "Enter 3 to get a game preview or recap"
      puts "Enter 5 to exit"
      selection = gets.strip
      case selection
      when "1"
        Nbascraper.today
      when "2"
        new_date
      when "3"
        Nbascraper.get_summary
      when "5"
        puts "Good-bye"
      else
        puts "Invalid selection."
      end 
    end    
  end

  def new_date
    puts "Please enter year in YYYY format"
    year = gets.strip
    puts "Please enter month in MM format"
    month = gets.strip
    puts "Please enter day of month in DD format"
    day = gets.strip
    date = "#{year}#{month}#{day}"
    Nbascraper.get_games(date)
  end

end

class DateError < StandardError
  def message 
    "Invalid Date"
  end
end