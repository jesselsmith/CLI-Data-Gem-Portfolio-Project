# frozen_string_literal: true

class Card
  attr_accessor :name, :mana_cost, :card_url, :daily_change, :weekly_change,
                :highest_price, :lowest_price, :sets
  attr_reader :decks

  @@all = []

  def initialize(name:, mana_cost:, card_url:)
    @name = name
    @mana_cost = mana_cost
    @card_url = card_url
  end

  def self.create(name:, mana_cost:, card_url:)
    self.new(name: name, mana_cost: mana_cost, card_url: card_url)
    @@all << self
  end

  # takes in a name string and converts it to a symbol
  def self.symbolize(name_string)
    # replaces all the spaces with underscores, downcases before converting
    name_string.gsub(/\s+/, '_').downcase.to_sym
  end

  def add_deck(deck_object)
    name_symbol = symbolize(deck_object.name)
    if @decks.is_a? Hash
      @decks[name_symbol] = deck_object unless @decks.key?(name_symbol)
    else
      @decks = {
        name_symbol => deck_object
      }
    end
    deck_object.add_card(self) unless deck_object.has_card? self
  end

  def self.all
    @@all
  end

  def add_set(set_name_string)
    if @sets.is_a? Array
      @sets << set_name_string unless @sets.include? set_name_string
    else
      @sets = [set_name_string]
    end
  end
end
