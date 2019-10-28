require_relative 'spec_helper'

describe 'Card' do
  let(:card) { Card.new(name: 'Primeval Titan', mana_cost: '4GG', card_url: 'price/Magic+2012/Primeval+Titan#paper') }

  describe '#initialize' do
    it 'accepts a name, mana_cost, and card_url' do
      new_card = Card.new(name: 'Oko, Thief of Crowns', mana_cost: '1UG', card_url: 'price/Throne+of+Eldraine/Oko+Thief+of+Crowns#paper')
      expect(new_card.name).to eq('Oko, Thief of Crowns')
      expect(new_card.mana_cost).to eq('1UG')
      expect(new_card.card_url).to eq('price/Throne+of+Eldraine/Oko+Thief+of+Crowns#paper')
    end
  end
end


describe 'Deck' do
  let(:oko) do
    Card.new(name: 'Oko, Thief of Crowns', mana_cost: '1UG',
             card_url: 'price/Throne+of+Eldraine/Oko+Thief+of+Crowns#paper')
  end

  let(:nissa) do
    Card.new(name: 'Nissa, Who Shakes the World', mana_cost: '3GG',
             card_url: 'price/War+of+the+Spark/Nissa+Who+Shakes+the+World#paper')
  end

  let(:krasis) do
    Card.new(name: 'Hydroid Krasis', mana_cost: 'XUG',
             card_url: 'price/Promo+Pack+Throne+of+Eldraine/Hydroid+Krasis#paper')
  end

  describe '#initialize' do
    it 'accepts a name, colors, featured_cards, meta_percent, online_price, paper_price, and deck_url' do
      deck = Deck.new(name: 'UG Walkers', colors: 'UG', 
                      featured_cards: [oko, nissa, krasis], meta_percent: 17.2, online_price: 600.11,
                      paper_price: 875.24, deck_url: 'archetype/standard-ug-walkers-101386#paper')
      expect(deck.name).to eq('UG Walkers')
      expect(deck.colors).to eq('UG')
      expect(deck.featured_cards).to eq([oko, nissa, krasis])
      expect(deck.meta_percent).to eq(17.2)
      expect(deck.online_price).to eq(600.11)
      expect(deck.paper_price).to eq(875.24)
      expect(deck.deck_url).to eq('archetype/standard-ug-walkers-101386#paper')
    end
  end
end
