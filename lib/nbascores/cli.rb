require_relative '../nbascores/nba_stat.rb'

class Nbascores::CLI

  def call
    list
  end

  def list
    selection = ""
    until selection == "3"
      puts "Enter 1 to refresh today's scores"
      puts "Enter 2 to see another day's scores"
      puts "Enter 3 to exit"
      selection = gets.strip
      puts "*************************"
      case selection
      when "1"
        show_score(today)
        NBAStat.find_by_date(today) != [] ? show_summary(today) : (puts "No games or invalid date")
      when "2"
        date = newdate
        show_score(date)
        NBAStat.find_by_date(date) != [] ? show_summary(date) : (puts "No games or invalid date")
      when "3"
        puts "Good-bye"
      else
        puts "Invalid selection."
      end 
      puts "*************************"
    end    
  end

  def today
    Time.now.strftime("%Y%m%d")
  end

  def newdate
    begin
      puts "Please enter year in YYYYMMDD format"
      date = gets.strip
      url = "http://data.nba.com/data/1h/json/cms/noseason/scoreboard/#{date}/games.json"
      open(url)
    rescue OpenURI::HTTPError
    else
      date
    end
  end

  def show_score(date)
    Nbascores::Nbascrape.scrape(date)
    NBAStat.find_by_date(date).each_with_index do |game,i|
      puts "#{i+1}. #{game.away} - #{game.away_score} #{game.home} - #{game.home_score} #{game.period}"
    end
    puts "*************************"
  end

  def show_summary(date)
    selection = ""
    until selection == NBAStat.find_by_date(date).size+1
      puts "Enter 1-#{NBAStat.find_by_date(date).size} to see the game's preview or recap"
      puts "Enter #{(NBAStat.find_by_date(date).size+1).to_s} to return to main menu"
      selection = gets.strip.to_i
      case selection
      when 1..NBAStat.find_by_date(date).size
        puts "*************************"
        puts NBAStat.find_by_date(date)[selection-1].summary_scrape
        puts "*************************"
      when NBAStat.find_by_date(date).size+1
        #returns to main menu
      else
        puts "*************************"
        puts "Invalid selection."
        puts "*************************"
      end
    end
  end

end