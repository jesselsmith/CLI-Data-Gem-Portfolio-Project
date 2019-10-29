require_relative 'spec_helper'

describe 'Card' do
  let(:oko) do
    Card.create(name: 'Oko, Thief of Crowns', mana_cost: '1UG',
             card_url: 'price/Throne+of+Eldraine/Oko+Thief+of+Crowns#paper',
            image_url: 'https://cdn1.mtggoldfish.com/images/gf/Primeval%2BTitan%2B%255BM12%255D.jpg')
  end
  
  let(:nissa) do
    Card.create(name: 'Nissa, Who Shakes the World', mana_cost: '3GG',
             card_url: 'price/War+of+the+Spark/Nissa+Who+Shakes+the+World#paper',
            image_url: 'https://cdn1.mtggoldfish.com/images/gf/Primeval%2BTitan%2B%255BM12%255D.jpg')
  end
  
  let(:krasis) do
    Card.create(name: 'Hydroid Krasis', mana_cost: 'XUG',
             card_url: 'price/Promo+Pack+Throne+of+Eldraine/Hydroid+Krasis#paper',
            image_url: 'https://cdn1.mtggoldfish.com/images/gf/Primeval%2BTitan%2B%255BM12%255D.jpg')
  end
  
  let(:deck_initilization_hash) do
    {
      name: 'Amulet Titan',
      colors: 'UG',
      featured_cards: ['Azusa, Lost but Seeking', 'Amulet of Vigor', 'Summoner\'s Pact'],
      meta_percent: 5.75,
      online_price: 291,
      paper_price: 757,
      deck_url: 'archetype/modern-amulet-titan-88330#paper'
    }
  end

  let(:titan) do
    Card.new(name: 'Primeval Titan', mana_cost: '4GG', card_url: 'price/Magic+2012/Primeval+Titan#paper', 
    image_url: 'https://cdn1.mtggoldfish.com/images/gf/Primeval%2BTitan%2B%255BM12%255D.jpg')
    end
  

  describe '#initialize' do
    it 'accepts a name, mana_cost, and card_url' do
      new_card = Card.new(name: 'Oko, Thief of Crowns', mana_cost: '1UG', card_url: 'price/Throne+of+Eldraine/Oko+Thief+of+Crowns#paper',
      image_url: 'https://cdn1.mtggoldfish.com/images/gf/Primeval%2BTitan%2B%255BM12%255D.jpg')
      expect(new_card.name).to eq('Oko, Thief of Crowns')
      expect(new_card.mana_cost).to eq('1UG')
      expect(new_card.card_url).to eq('price/Throne+of+Eldraine/Oko+Thief+of+Crowns#paper')
    end
  end

  describe '.create' do
    it 'saves a card to the @@all class variable array' do
      new_card = Card.create(name: 'Oko, Thief of Crowns', mana_cost: '1UG', card_url: 'price/Throne+of+Eldraine/Oko+Thief+of+Crowns#paper',
      image_url: 'https://cdn1.mtggoldfish.com/images/gf/Primeval%2BTitan%2B%255BM12%255D.jpg')
      expect(Card.all).to eq([new_card])
    end
  end

  describe "#add_deck" do
    it 'adds a deck to the @decks hash and adds the card to the deck if its not already there' do
      deck =  Deck.new(deck_initilization_hash)
      titan.add_deck(deck)
      expect(titan.decks[:amulet_titan]).to eq(deck)
      expect(deck.card? titan).to eq(true) 
    end
  end
  
end


describe 'Deck' do
  let(:oko) do
    Card.create(name: 'Oko, Thief of Crowns', mana_cost: '1UG',
             card_url: 'price/Throne+of+Eldraine/Oko+Thief+of+Crowns#paper',
            image_url: 'https://cdn1.mtggoldfish.com/images/gf/Primeval%2BTitan%2B%255BM12%255D.jpg')
  end
  
  let(:nissa) do
    Card.create(name: 'Nissa, Who Shakes the World', mana_cost: '3GG',
             card_url: 'price/War+of+the+Spark/Nissa+Who+Shakes+the+World#paper',
            image_url: 'https://cdn1.mtggoldfish.com/images/gf/Primeval%2BTitan%2B%255BM12%255D.jpg')
  end
  
  let(:krasis) do
    Card.create(name: 'Hydroid Krasis', mana_cost: 'XUG',
             card_url: 'price/Promo+Pack+Throne+of+Eldraine/Hydroid+Krasis#paper', image_url: 'https://cdn1.mtggoldfish.com/images/gf/Primeval%2BTitan%2B%255BM12%255D.jpg')
  end

  let(:titan) do
    Card.new(name: 'Primeval Titan', mana_cost: '4GG', card_url: 'price/Magic+2012/Primeval+Titan#paper', 
    image_url: 'https://cdn1.mtggoldfish.com/images/gf/Primeval%2BTitan%2B%255BM12%255D.jpg')
    end
  
  let(:deck_initilization_hash) do
    {
      name: 'Amulet Titan',
      colors: 'UG',
      featured_cards: ['Azusa, Lost but Seeking', 'Amulet of Vigor', 'Summoner\'s Pact'],
      meta_percent: '5.75%',
      online_price: '$291',
      paper_price: '$757',
      deck_url: 'archetype/modern-amulet-titan-88330#paper'
    }
  end

  describe '#initialize' do
    it 'accepts a name, colors, featured_cards, meta_percent, online_price, paper_price, and deck_url' do
      deck = Deck.new(name: 'UG Walkers', colors: 'UG',
                      featured_cards: ['Oko, Thief of Crowns', 'Nissa, Who Shakes the World', 'Hydroid Krasis'], 
                      meta_percent: '17.2%', online_price: '$600.11',
                      paper_price: '$875.24', deck_url: 'archetype/standard-ug-walkers-101386#paper')
      expect(deck.name).to eq('UG Walkers')
      expect(deck.colors).to eq('UG')
      expect(deck.featured_cards).to eq(['Oko, Thief of Crowns', 'Nissa, Who Shakes the World', 'Hydroid Krasis'])
      expect(deck.meta_percent).to eq('17.2%')
      expect(deck.online_price).to eq('$600.11')
      expect(deck.paper_price).to eq('$875.24')
      expect(deck.deck_url).to eq('archetype/standard-ug-walkers-101386#paper')
    end
  end

  describe '.create' do
    it 'saves a deck to the @@all class variable array' do
      new_deck = Deck.create(deck_initilization_hash)
      expect(Deck.all.first).to eq(new_deck)
    end
  end

  describe '#add_card' do
    it 'adds the card to the deck, and adds the deck to the card' do
      new_deck = Deck.new(deck_initilization_hash)
      new_deck.add_card(titan, 4)
      expect(new_deck.card?(titan)).to eq(true)
      expect(new_deck.cards[:primeval_titan][:card]).to eq(titan)
      expect(new_deck.cards[:primeval_titan][:quantity]).to eq(4)
      expect(titan.decks.key?(:amulet_titan)).to eq(true)
    end

    it 'increases the quantity of the existing hash entry rather than adding another' do
      new_deck = Deck.new(deck_initilization_hash)
      new_deck.add_card(titan, 2)
      new_deck.add_card(titan, 1)
      expect(new_deck.cards[:primeval_titan][:quantity]).to eq(3)
    end


    it 'checks to make sure this won\'t take the quantity over 4' do
      new_deck = Deck.new(deck_initilization_hash)
      new_deck.add_card(titan, 4)
      new_deck.add_card(titan, 2)
      expect(new_deck.cards[:primeval_titan][:quantity]).to eq(4)
      new_deck.add_card(oko, 1)
      new_deck.add_card(oko, 4)
      expect(new_deck.cards[:oko_thief_of_crowns][:quantity]).to eq(1)
    end
  end
end
