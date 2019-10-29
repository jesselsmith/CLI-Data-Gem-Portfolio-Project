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

    featured_cards = decks.css(".archetype-tile-description ul").map do |list|
      list.css("li").map(&:text)
    end.first(12)
    
    meta_percents = decks.css(".table-condensed.stats .col-freq").map { |element| element.text.strip }.first(12)

    {
      names: names,
      urls: urls,
      colors: colors,
      featured_cards: featured_cards,
      meta_percents: meta_percents
    }



  end


  
end
