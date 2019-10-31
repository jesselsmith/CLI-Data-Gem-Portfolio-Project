# frozen_string_literal: true

require_relative '../config/environment'
require_relative './concerns/findable'
require_relative './concerns/symbolizable'

require 'colorize'

class Deck
  extend Concerns::Findable
  include Concerns::Symbolizable
  attr_accessor :name, :featured_cards, :colors, :meta_percent, :online_price,
                :paper_price, :deck_url
  attr_reader :cards, :mtg_format

  @@all =  []

  def mtg_format=(mtg_format)
    @mtg_format = mtg_format
    mtg_format.add_deck(self) unless mtg_format.decks.include?(self)
  end

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

  def add_card(card_to_add, quantity = 1)
    name_symbol = symbolize(card_to_add.name)
    if @cards.is_a? Hash
      if @cards[name_symbol].nil?
        @cards[name_symbol] = { card: card_to_add, quantity: quantity}
      else
        @cards[name_symbol][:quantity] += quantity unless @cards[name_symbol][:quantity] + quantity > 4
      end
    else
      @cards = { name_symbol => { card: card_to_add, quantity: quantity } }
    end
    card_to_add.add_deck(self)
  end

  def card?(card_object)
    @cards.nil? ? false : @cards.key?(symbolize(card_object.name))
  end

  def how_many?(card_name_string)
    if @cards.nil? || @cards[symbolize(card_name_string)].nil?
      0
    else
      @cards[symbolize(card_name_string)][:quantity]
    end
  end

  def print_deck
    puts name.colorize(:magenta)
    @cards.each do |card|
      puts "#{card[1][:quantity]} #{card[1][:card].name_in_color}"
    end
  end
end
