# frozen_string_literal: true

class Deck
  attr_accessor :name, :featured_cards, :colors, :meta_percent, :online_price,
                :paper_price, :deck_url
  attr_reader :cards

  def initialize(name:, featured_cards:, colors:, meta_percent:, online_price:, paper_price:, deck_url:)
    @name = name
    @featured_cards = fee

  end

end
