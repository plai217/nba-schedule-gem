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
        Nbascores::Nbascrape.clear
        show_score(today)
        Nbascores::Nbascrape.all != [] ? show_summary : (puts "No games or invalid date")
      when "2"
        Nbascores::Nbascrape.clear
        show_score(newdate)
        Nbascores::Nbascrape.all != [] ? show_summary : (puts "No games or invalid date")
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
    Nbascores::Nbascrape.all.each_with_index do |game,i|
      puts "#{i+1}. #{game.away} - #{game.away_score} #{game.home} - #{game.home_score} #{game.period}"
    end
    puts "*************************"
  end

  def show_summary
    selection = ""
    until selection == Nbascores::Nbascrape.all.size+1
      puts "Enter 1-#{Nbascores::Nbascrape.all.size} to see the game's preview or recap"
      puts "Enter #{(Nbascores::Nbascrape.all.size+1).to_s} to return to main menu"
      selection = gets.strip.to_i
      case selection
      when 1..Nbascores::Nbascrape.all.size
        puts "*************************"
        puts Nbascores::Nbascrape.all[selection-1].summary_scrape
        puts "*************************"
      when Nbascores::Nbascrape.all.size+1
        #returns to main menu
      else
        puts "*************************"
        puts "Invalid selection."
        puts "*************************"
      end
    end
  end

end