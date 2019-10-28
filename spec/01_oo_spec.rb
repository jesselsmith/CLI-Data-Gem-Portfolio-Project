require_relative 'spec_helper'

describe "Card" do
  let(:card) { Card.new("Primeval Titan", "4GG", "price/Magic+2012/Primeval+Titan") }
  describe "#initialize" do
    it 'accepts a name, mana_cost, and card_url' do
      new_card = Card.new(name: "Oko, Thief of Crowns", mana_cost: "1UG", card_url: "price/Throne+of+Eldraine/Oko+Thief+of+Crowns")
      expect(new_card.name).to eq("Oko, Thief of Crowns")
      expect(new_card.mana_cost).to eq("1UG")
      expect(new_card.card_url).to eq("price/Throne+of+Eldraine/Oko+Thief+of+Crowns")
    end
  end
end


describe "Deck" do
  describe "#initialize" do
    it 'accepts a name, colors, featured_cards, meta_percent, and deck_url' do
      deck = Deck.new("UG Walkers", "UG", "")
      expect 
    end
  end
end
