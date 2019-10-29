require_relative 'spec_helper'

describe 'Scraper' do
  let(:modern_url){"/metagame/modern#paper"}
  describe '.scrape_top_12_decks' do
    it 'correctly collects all the names of the top 12 decks' do
      scrape_results = Scraper.scrape_top_12_decks(modern_url)

      expect(scrape_results[:names]).to eq([
        "Amulet Titan",
        "Burn",
        "Eldrazi Tron",
        "Tron",
        "Urza Outcome",
        "Jund",
        "Grixis Death's Shadow",
        "Four-Color Whirza",
        "Azorious Stoneblade",
        "Dredge",
        "Titanshift",
        "Humans"
         ])

         expect(scrape_results[:urls].first).to eq("/archetype/modern-amulet-titan-88330#paper")
    end

  end
end
