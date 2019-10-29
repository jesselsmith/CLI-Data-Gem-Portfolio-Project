require 'open-uri'
require 'nokogiri'

class Scraper
  BASE_URL = "https://www.mtggoldfish.com"

  def self.scrape_top_12_decks(url_add_on) 
    doc = Nokogiri::HTML(URI.open(BASE_URL + url_add_on))

    decks = doc.css(".archetype-tile")

    names = decks.css(".deck-price-paper a").map(&:text).first(12)
    urls = decks.css(".deck-price-paper a").map { |element| element.attribute("href").value }.first(12)
    colors = decks.css(".manacost-container").map do |container|
      color_letters = container.css(".common-manaCost-manaSymbol").map{ |element| element.attribute("alt").value }.join
      color_letters == '' ? 'colorless' : color_letters.upcase
    end.first(12)
    {
      names: names,
      urls: urls,
      colors: colors,
      featured_cards: featured_cards
    }



  end


  
end
