class Nbascores::Nbascrape

  attr_reader :away, :home, :period, :url, :summary, :away_score, :home_score
  @@all = []

  def initialize(away = nil, home = nil, period = nil, url = nil, away_score = nil, home_score = nil)
    @away = away
    @home = home
    @period = period
    @url = url
    @away_score = away_score
    @home_score = home_score
    @@all << self
  end

  def self.all
    @@all
  end

  def self.clear
    self.all.clear
  end

  def self.scrape(date)
    url = "http://data.nba.com/data/1h/json/cms/noseason/scoreboard/#{date}/games.json"
    doc = JSON.parse(open(url).read)
    if doc["sports_content"]["games"]["game"] != nil 
      doc["sports_content"]["games"]["game"].each do |game|
        new(game["visitor"]["nickname"],game["home"]["nickname"],game["period_time"]["period_status"],game["game_url"],game["visitor"]["score"],game["home"]["score"])
      end
    end
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

