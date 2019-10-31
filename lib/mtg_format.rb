# frozen_string_literal: true

require_relative '../config/environment'
require_relative './concerns/findable'

class MtgFormat
  extend Concerns::Findable

  attr_accessor :name, :format_url, :decks

  @@all = []

  def self.url_from_format_name(format_name_string)
    "/metagame/#{format_name_string}#paper"
  end


  def initialize(name:, format_url: url_from_format_name(name), decks_array:)
    @name = name
    @format_url = format_url
    @decks = decks_array
  end

  def self.create(name:, format_url: url_from_format_name(name), decks_array:)
    new_format = self.new(name: name, format_url: format_url, decks_array: decks_array)
    @@all << new_format
    new_format
  end

  def self.all
    @@all
  end

  def display_format
    @decks.each.with_index(1) do |deck, i|
      puts "#{i}. #{deck.name} | Colors: #{deck.colors}"
      puts "  -Featured Cards: #{deck.featured_cards.join(' | ')}"
      puts "  -Metagame Percentage: #{deck.meta_percent} | Paper Price: #{deck.paper_price} | Online Price: #{deck.online_price}"
    end
  end
end
