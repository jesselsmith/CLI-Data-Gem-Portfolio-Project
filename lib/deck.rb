# frozen_string_literal: true

class Deck
  attr_accessor :name, :featured_cards, :colors, :meta_percent, :online_price,
                :paper_price, :deck_url
  attr_reader :cards

  @@all =  []

  def initialize(name:, featured_cards:, colors:, meta_percent:, online_price:, paper_price:, deck_url:)
    @name = name
    @featured_cards = featured_cards
    @colors = colors
    @meta_percent = meta_percent
    @online_price = online_price
    @paper_price = paper_price
    @deck_url = deck_url
  end

  def self.create(name:, featured_cards:, colors:, meta_percent:, online_price:, paper_price:, deck_url:)
    new_deck = self.new(name: name, featured_cards: featured_cards, colors: colors, meta_percent: meta_percent, online_price: online_price, paper_price: paper_price, deck_url: deck_url)
    @@all << new_deck
    new_deck
  end

  def self.all
    @@all
  end


end
