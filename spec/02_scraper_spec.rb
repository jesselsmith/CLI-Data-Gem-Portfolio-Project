require_relative 'spec_helper'

describe 'Scraper' do
  let(:modern_url){"/metagame/modern#paper"}
  describe '.scrape_top_12_decks' do
    let(:scrape_results){ Scraper.scrape_top_12_decks(modern_url) }

    it 'correctly collects all the names of the top 12 decks' do
      expect(scrape_results[:names]).to eq([
        "Amulet Titan",
        "Burn",
        "Eldrazi Tron",
        "Tron",
        "Urza Outcome",
        "Jund",
        "Grixis Death's Shadow",
        "Four-Color Whirza",
        "Azorius Control",
        "Dredge",
        "Titanshift",
        "Humans"
         ])
    end
    
    it 'correctly collects the urls' do
      expect(scrape_results[:urls].first).to eq("/archetype/modern-amulet-titan-88330#paper")
    end

    it 'correctly collects the colors' do
      expect(scrape_results[:colors][3]).to eq("G")
    end

    it 'correctly collects the featured cards' do
      expect(scrape_results[:featured_cards][7]).to eq(['Mox Opal', 'Urza, Lord High Artificer', 'Mishra\'s Bauble'])
    end

    it 'correctly collects the meta percent' do
      expect(scrape_results[:meta_percents][11]).to eq('2.14')
    end

    it 'correctly collects the online and paper prices' do
      expect(scrape_results[:online_prices][2]).to eq('301')

      expect(scrape_results[:paper_prices][5]).to eq('1658')
    end
  end
end
