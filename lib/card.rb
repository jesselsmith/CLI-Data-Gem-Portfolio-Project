# frozen_string_literal: true

require_relative '../config/environment'
require_relative './concerns/findable'
require_relative './concerns/symbolizable'

class Card
  extend Concerns::Findable
  include Concerns::Symbolizable
  attr_accessor :name, :mana_cost, :card_url, :image_url, :online_price, :paper_price, :daily_change, :weekly_change,
                :highest_price, :lowest_price, :sets
  attr_reader :decks

  @@all = []

  def initialize(name:, mana_cost:, card_url:, image_url:)
    @name = name
    @mana_cost = mana_cost
    @card_url = card_url
    @image_url = image_url
  end

  def self.create(name:, mana_cost:, card_url:, image_url:)
    new_card = self.new(name: name, mana_cost: mana_cost, card_url: card_url, image_url: image_url)
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

  def add_more_info_with_hash(online_price:, paper_price:, daily_change:, weekly_change:, highest_price:, lowest_price:, sets:)
    @online_price = online_price
    @paper_price = paper_price
    @daily_change = daily_change
    @weekly_change = weekly_change
    @highest_price = highest_price
    @lowest_price = lowest_price
    @sets = sets
  end

  def self.find_card_by_name_or_create(card_attribute_hash)
    find_by_name(card_attribute_hash[:name]) || create(card_attribute_hash)
  end

  def name_in_color
    colors = @mana_cost.scan(/W|U|B|R|G/).uniq
    if colors.size > 1
      @name.colorize(:light_yellow)
    elsif colors.size == 0
      @name
    else
      case colors[0]
      when 'W'
        @name.colorize(:light_white)
      when 'U'
        @name.colorize(:blue)
      when 'B'
        @name.colorize(:light_black)
      when 'R'
        @name.colorize(:red)
      when 'G'
        @name.colorize(:green)
      end
    end
  end

  def price_changes_colorization(price_change_string)
    price_change_float = price_change_string.to_f
    if price_change_float.positive?
      price_change_string.colorize(:green)
    elsif price_change_float.zero?
      price_change_string.colorize(:light_black)
    else
      price_change_string.colorize(:red)
    end
  end

  def display_detailed_card
    puts "Name: #{name_in_color}\tMana Cost: #{@mana_cost}"
    puts "Image URL: #{@image_url}"
    puts "Paper Price: $#{@paper_price.colorize(:cyan)} | Online Price: #{@online_price.colorize(:cyan)}tix"
    puts "Daily Change: #{price_changes_colorization(@daily_change)} | Weekly Change: #{price_changes_colorization(@weekly_change)}"
    puts "Highest Price: $#{@highest_price.colorize(:cyan)} | Lowest Price: $#{@lowest_price.colorize(:cyan)}"
  end

end
