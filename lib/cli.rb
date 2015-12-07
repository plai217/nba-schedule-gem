require_relative "../lib/nbascraper.rb"
require 'nokogiri'
require 'pry'

class Nbascraper::CLI

  def run
    puts "Please enter year in YYYY format"
    year = gets.strip
    puts "Please enter month in MM format"
    month = gets.strip
    puts "Please enter day of month in DD format"
    day = gets.strip
    date = "#{year}#{month}#{day}"
    get_schedule(date)
  end

  def get_schedule(date)
    schedule = Nbascraper.scrape_index(date)
    binding.pry 
  end

end

