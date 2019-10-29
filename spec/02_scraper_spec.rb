require_relative 'spec_helper'

describe 'Scraper' do
  let(:modern_url){"metagame/modern#paper"}
  describe '.scrape_top_12_decks' do
    it 'correctly collects all the names of the top 12 decks' do
      expect(Scraper.scrape_top_12_decks(modern_url)).to eq([
        "Amulet Titan",
        "Burn",
        "Eldrazi Tron",
        "Tron",
        "Urza Outcome",
        "Jund",
        "Grixis Death's Shadow",
        "Four-Color Whirza",
        "Azorius Stoneblade",
        "Dredge",
        "Titanshift",
        "Humans"
         ])
    end

  end
end
