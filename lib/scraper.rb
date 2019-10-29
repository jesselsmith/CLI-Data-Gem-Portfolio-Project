require 'open-uri'
require 'nokogiri'

class Scraper
  BASE_URL = "https://www.mtggoldfish.com/"

  def scrape_top_10_decks(url_add_on) 
    doc = Nokogiri::HTML(URI.open(BASE_URL + url_add_on))

    decks = doc.css(".archetype-tile")

    names = decks.css(".deck-price-paper a").text

  end


  
end
