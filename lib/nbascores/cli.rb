class Nbascores::CLI

  def call
    start
  end

  def start
    Nbascores::Nbascrape.today
    list
  end

  def list
    selection = ""
    until selection == "5"
      puts "Enter 1 to refresh today's scores"
      puts "Enter 2 to see schedules and scores for another date"
      puts "Enter 3 to get a game preview or recap for selected date"
      puts "Enter 5 to exit"
      selection = gets.strip
      case selection
      when "1"
        Nbascores::Nbascrape.today
      when "2"
        new_date
      when "3"
        Nbascores::Nbascrape.get_summary
      when "5"
        puts "Good-bye"
      else
        puts "Invalid selection."
      end 
    end    
  end

  def new_date
    begin
      puts "Please enter year in YYYY format"
      year = gets.strip
      puts "Please enter month in MM format"
      month = gets.strip
      puts "Please enter day of month in DD format"
      day = gets.strip
      date = "#{year}#{month}#{day}"
        url = "http://data.nba.com/data/1h/json/cms/noseason/scoreboard/#{date}/games.json"
        open(url)
    rescue OpenURI::HTTPError
      puts "************************************"
      puts "Invalid date or no games on #{date}"
      puts "************************************"
      puts "Enter a valid date"
      new_date
    else
      Nbascores::Nbascrape.get_games(date)
    end 
    
  end

end