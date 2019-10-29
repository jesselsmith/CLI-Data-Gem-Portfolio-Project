# frozen_string_literal: true

require_relative '../config/environment'
require_relative './concerns/findable'
require_relative './concerns/symbolizable'

class Card
  extend Concerns::Findable
  include Concerns::Symbolizable
  attr_accessor :name, :mana_cost, :card_url, :online_price, :paper_price, :daily_change, :weekly_change,
                :highest_price, :lowest_price, :sets
  attr_reader :decks

  @@all = []

  def initialize(name:, mana_cost:, card_url:)
    @name = name
    @mana_cost = mana_cost
    @card_url = card_url
  end

  def self.create(name:, mana_cost:, card_url:)
    new_card = self.new(name: name, mana_cost: mana_cost, card_url: card_url)
    @@all << new_card
    new_card
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
    deck_object.add_card(self) unless deck_object.card? self
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
