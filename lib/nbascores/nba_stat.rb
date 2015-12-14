class NBAStat

  attr_accessor :away, :home, :period, :url, :summary, :away_score, :home_score, :date
  @@all = []

  def initialize(properties = {})
    properties.each do |property,value|
      self.send("#{property}=", value)
    end
    @@all << self
  end

  def self.all
    @@all
  end

  def self.clear
    self.all.clear
  end

  def self.game_exists(url)
    self.all.collect {|game| game.url == url}.include?(true)
  end

  def self.find_by_date(date)
    self.all.select {|game| game.date == date}
  end

  def self.find_by_url(url)
    self.all.first {|game| game.url == url}
  end

  def summary_scrape
    begin
      doc = Nokogiri::HTML(open("http://www.nba.com/games/#{url}/gameinfo.html?ls=iref:nba:scoreboard")) 
    rescue OpenURI::HTTPError
      @summary = "No recap available"
    else
      if doc.css("#nbaGIRecap2 p").text == ""
        @summary = doc.css("#nbaGIPreview p").text
      else
        @summary = doc.css("#nbaGIRecap2 p").text
      end
    end
  end

end


# Given a day, create an NBA Stat object to read from.