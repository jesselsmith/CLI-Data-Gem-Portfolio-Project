require_relative 'spec_helper'

  describe '.scrape_decklist' do
    let(:completed_deck) { Scraper.scrape_decklist(Scraper.scrape_top_12_decks("/metagame/modern#paper")[0]) }
    it 'scrapes all the cards in the deck' do
      deck_object = completed_deck
      expect(deck_object.cards.key?(:once_upon_a_time)).to eq (true)
      expect(deck_object.cards.key?(:engineered_explosives)).to eq(true)
      expect(deck_object.cards.key?(:disdainful_stroke)).to eq(true)
    end

    it 'gets them in the right quantities' do
      deck_object = completed_deck
      expect(deck_object.cards[:engineered_explosives][:quantity]).to eq(3)
      expect(deck_object.cards[:selesneya_sanctuary][:quantity]).to eq(1)
    end

    it 'builds card objects for each card' do
      deck_object = completed_deck
      expect(deck_object.cards[:primeval_titan][:card].is_a?(Card)).to eq(true)
    end

    it 'does not build card objects that have already been built' do
      expect(Card.all.group_by { |e| e }.find { |_k, v| v.size > 1 }.nil?).to eq(true)
    end
  end