require_relative 'spec_helper'

describe 'Scraper' do
  describe '.scrape_card_info' do
    let(:titan) do
      modern_decks = Scraper.scrape_top_12_decks('/metagame/modern#paper')
      amulet_titan_deck = Scraper.scrape_decklist(modern_decks[0])
      Scraper.scrape_card_info(amulet_titan_deck.cards[:primeval_titan][:card])
    end

    it 'scrapes an image url' do
      expect(titan[:image_url]).to eq("https://cdn1.mtggoldfish.com/images/gf/Primeval%2BTitan%2B%255BMM2%255D.jpg")
    end

    it 'collects the online price' do
      expect(titan[:online_price]).to eq('2.59')
    end

    it 'collects the paper price' do
      expect(titan[:paper_price]).to eq('10.86')
    end

    it 'scrapes the daily and weekly change' do
      expect(titan[:daily_change]).to eq('-0.06')
      expect(titan[:weekly_change]).to eq('0.00')
    end

    it 'scrapes the highest and lowest price' do
      expect(titan[:highest_price]).to eq('16.48')
      expect(titan[:lowest_price]).to eq('8.16')
    end

    it 'scrapes all the sets and printings of the card' do
      expect(titan[:sets]).to eq(%w[DPA IMA M11 M12 MM2 PRM])
    end

    it 'adds all this to the card object properly' do
      expect(titan.highest_price).to eq('16.48')
      expect(titan.weekly_change).to eq('0.00')
      expect(titan.paper_price).to eq('10.86')
      expect(titan.sets).to eq(%w[DPA IMA M11 M12 MM2 PRM])
    end
  end
  
end
