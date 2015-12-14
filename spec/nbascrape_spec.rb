require 'spec_helper'

describe 'Nbascores::Nbascrape' do 
  # it 'works' do
  #   expect(Nbascores::Nbascrape).to be_a(Class)
  # end

  context '#initialize' do
    it 'creates an instance with properties based on the hash passed' do
      # Setup
      properties = {:away => "Nets", :home => "Knicks", :away_score => 80, :home_score => 90}

      # Do something
      nba_stat = Nbascores::Nbascrape.new(properties)

      # check your result
      expect(nba_stat.away).to eq("Nets")
      expect(nba_stat.home).to eq("Knicks")
      expect(nba_stat.away_score).to eq(80)
      expect(nba_stat.home_score).to eq(90)
    end
  end
end