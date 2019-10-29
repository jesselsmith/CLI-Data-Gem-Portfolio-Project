require_relative 'spec_helper'

describe 'Scraper' do
  let(:modern_url){"/metagame/modern#paper"}
  describe '.scrape_top_12_decks' do
    let(:scrape_results){ Scraper.scrape_top_12_decks(modern_url) }

    it 'correctly collects all the names of the top 12 decks' do
      expect(scrape_results.map(&:name)).to eq([
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
      expect(scrape_results.first.deck_url).to eq("/archetype/modern-amulet-titan-88330#paper")
    end

    it 'correctly collects the colors' do
      expect(scrape_results[3].colors).to eq("G")
    end

    it 'correctly collects the featured cards' do
      expect(scrape_results[7].featured_cards).to eq(['Mox Opal', 'Urza, Lord High Artificer', 'Mishra\'s Bauble'])
    end

    it 'correctly collects the meta percent' do
      expect(scrape_results[11].meta_percent).to eq('2.16%')
    end

    it 'correctly collects the online and paper prices' do
      expect(scrape_results[2].online_price).to eq('296tix')

      expect(scrape_results[5].paper_price).to eq('$1,680')
    end
  end
end
