require 'open-uri'
require 'nokogiri'
require 'colorize'

class Scraper
  BASE_URL = 'https://www.mtggoldfish.com'

  def self.text_of_html_elements(html_node)
    html_node.map { |element| element.text.gsub(/[[:space:]]+/, '') }
  end

  def self.mana_extractor(html_node)
    html_node.map do |container|
      container.css('.common-manaCost-manaSymbol').map do |element| 
        mana_symbol = element.attribute('alt').value.upcase
        case mana_symbol
        when 'W'
          mana_symbol.colorize(:light_white)
        when 'U'
          mana_symbol.colorize(:blue)
        when 'B'
          mana_symbol.colorize(:light_black)
        when 'R'
          mana_symbol.colorize(:red)
        when 'G'
          mana_symbol.colorize(:green)
        else
          mana_symbol
        end
      end.join
    end
  end


  def self.scrape_top_12_decks(format_url) 
    doc = Nokogiri::HTML(URI.open(BASE_URL + format_url))

    decks = doc.css('.archetype-tile')

    names = decks.css('.deck-price-paper a').map(&:text).first(12)
    urls = decks.css('.deck-price-paper a').map { |element| element.attribute('href').value }.first(12)
    colors = mana_extractor(decks.css('.manacost-container')).first(12)

    featured_cards = decks.css('.archetype-tile-description ul').map do |list|
      list.css('li').map{ |list_item| list_item.text.colorize(:light_red) }
    end.first(12)

    meta_percents = text_of_html_elements(decks.css('.table-condensed.stats .col-freq')).first(12)

    online_prices = text_of_html_elements(decks.css('.stats .deck-price-online')).first(12)

    paper_prices = text_of_html_elements(decks.css('.stats .deck-price-paper')).first(12)

    names.map.with_index do |name, index|
      Deck.create(name: name, deck_url: urls[index], colors: colors[index],
                  featured_cards: featured_cards[index],
                  meta_percent: meta_percents[index],
                  online_price: online_prices[index],
                  paper_price: paper_prices[index])
    end
  end

  def self.scrape_decklist(deck)
    doc = Nokogiri::HTML(URI.open(BASE_URL + deck.deck_url))
  
    paper_tab = doc.css('#tab-paper').children

    card_names = paper_tab.css('.deck-col-card a').map(&:text)

    card_quantities = paper_tab.css('.deck-col-qty').map { |element| element.text.gsub(/[[:space:]]+/, '').to_i }

    card_urls = paper_tab.css('.deck-col-card a').map { |e| e.attribute('href').value }

    mana_costs = mana_extractor(paper_tab.css('.deck-col-mana'))

    card_images = paper_tab.css('.deck-col-card a').map { |e| e.attribute('data-full-image').value }

    card_names.each_with_index do |name, index|
      card_attribute_hash = {
        name: name,
        card_url: card_urls[index],
        mana_cost: mana_costs[index],
        image_url: card_images[index]
      }

      deck.add_card(Card.find_card_by_name_or_create(card_attribute_hash), card_quantities[index])
    end
    deck
  end

  def self.scrape_card_info(card)
    doc = Nokogiri::HTML(URI.open(BASE_URL + card.card_url))
  
    prices =  doc.css(".price-box-price")

    hash_to_add_to_card = {}
    hash_to_add_to_card[:image_url] = doc.css(".price-card-image-image").attribute("src").value
    hash_to_add_to_card[:online_price] = prices[0].text
    hash_to_add_to_card[:paper_price] = prices[1].text
    hash_to_add_to_card
  end
  
end
