require 'open-uri'
require 'nokogiri'
require 'pry'
require 'json'

class Scraper

  def self.scrape_index(current_url)
    puts current_url
    doc = Nokogiri::HTML(open(current_url))
    games = {}    
    doc.css(".schedules-list-matchup").each do |game|
         binding.pry 
      title = "#{game.css(".team-name.away").text} at #{game.css(".team-name.home").text}"
        games[title.to_sym] = {
          :time => "#{game.css(".time").text} #{game.css(".pm").text}ET",
          :away => game.css(".team-name.away").text, 
          :home =>  game.css(".team-name.home").text
        }
    end
    games
  end

end



#game.css(".time").text
#game.css(".pm").text
#game.css(".team-name.away").text
#game.css(".team-name.home").text
#yui_3_10_3_1_1449436176405_3379
#yui_3_10_3_1_1449436176405_3217 > span:nth-child(1) > span
#yui_3_10_3_1_1449436176405_3217 > span:nth-child(1) > span
#//*[@id="yui_3_10_3_1_1449436176405_3217"]/span[1]/span