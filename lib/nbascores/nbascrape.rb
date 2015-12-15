class Nbascores::Nbascrape

  def self.scrape(date)
    url = "http://data.nba.com/data/1h/json/cms/noseason/scoreboard/#{date}/games.json"
    doc = JSON.parse(open(url).read)
    if doc["sports_content"]["games"]["game"] != nil 
      doc["sports_content"]["games"]["game"].each do |game|
        if NBAStat.game_exists(game["game_url"])
          NBAStat.find_by_url(game["game_url"]).away_score = game["visitor"]["score"]
          NBAStat.find_by_url(game["game_url"]).home_score = game["home"]["score"]
          NBAStat.find_by_url(game["game_url"]).period = game["period_time"]["period_status"]
        else
          NBAStat.new({:away =>  game["visitor"]["nickname"],
              :home => game["home"]["nickname"],
              :period => game["period_time"]["period_status"],
              :url => game["game_url"],
              :away_score => game["visitor"]["score"],
              :home_score => game["home"]["score"],:date => date})
        end
      end
    end
  end 

end

