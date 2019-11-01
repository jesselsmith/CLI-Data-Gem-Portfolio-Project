class CliController

  MTG_FORMAT_LIST = %w[standard modern pioneer pauper legacy vintage].freeze

  def self.greeting
    puts 'Welcome to ' + 'M:tG Metagame Scraper'.colorize(:light_blue) + '!'
  end

  def self.list_format_selection
    puts 'Select an option from the list below:'
    MTG_FORMAT_LIST.each.with_index(1) do |mtg_format, i|
      puts "#{i.to_s.colorize(:yellow)}. Show me the top 12 " +
           "#{mtg_format.capitalize.colorize(:light_green)} decks."
    end
    user_input = ''
    until valid_format_selection_choice?(user_input)
      puts 'What would you like to do? [enter ' +
           "1-#{MTG_FORMAT_LIST.size}".colorize(:yellow) +
           " or '#{'exit'.colorize(:yellow)}' to exit]:"
      user_input = gets.strip.downcase
    end
    user_input
  end

  def self.valid_format_selection_choice?(input_string)
    input_string == 'exit' ||
      (1..(MTG_FORMAT_LIST.size)).include?(input_string.to_i) ||
      MTG_FORMAT_LIST.include?(input_string)
  end

  def self.format_selection_execution(user_choice)
    if (1..(MTG_FORMAT_LIST.size)).include?(user_choice.to_i)
      choose_format(MTG_FORMAT_LIST[user_choice.to_i - 1])
    elsif MTG_FORMAT_LIST.include?(user_choice)
      choose_format(user_choice)
    elsif user_choice == 'exit'
      goodbye
    end
  end

  def self.goodbye
    puts "Thanks for using #{'M:tG Metagame Scraper'.colorize(:light_blue)}!" +
         ' Goodbye!'
  end

  def self.start
    greeting
    user_choice = list_format_selection
    format_selection_execution(user_choice)
  end

  def self.find_or_scrape_format(mtg_format_string)
    existing_format = MtgFormat.find_by_name(mtg_format_string)
    if existing_format
      existing_format
    else
      format_url = MtgFormat.url_from_format_name(mtg_format_string)

      decks = Scraper.scrape_top_12_decks(format_url)

      MtgFormat.create(name: mtg_format_string, decks_array: decks)
    end
  end

  def self.valid_deck_selection_choice?(user_input_string)
    ['list formats', 'exit'].include?(user_input_string) ||
      (1..12).include?(user_input_string.to_i)
  end

  def self.list_deck_selection(mtg_format)
    puts 'The top 12 decks of ' +
         "#{mtg_format.name.capitalize.colorize(:light_green)} are:"
    mtg_format.display_format
    user_input = ''
    until valid_deck_selection_choice?(user_input)
      puts "Enter the number (#{'1-12'.colorize(:yellow)}) of the deck you'd" +
           " like to see, '#{'list formats'.colorize(:yellow)}'"
      puts "to see another format, or '#{'exit'.colorize(:yellow)}' to exit." +
           ' What would you like to do?:'
      user_input = gets.strip.downcase
    end
    user_input
  end

  def self.deck_selection_execution(mtg_format, user_choice)
    if (1..12).include?(user_choice.to_i)
      choose_decklist(mtg_format.decks[user_choice.to_i - 1])
    elsif user_choice == 'list formats'
      format_selection_execution(self.list_format_selection)
    elsif user_choice == 'exit'
      goodbye
    end
  end
  
  def self.choose_format(mtg_format_string)
    mtg_format = find_or_scrape_format(mtg_format_string)

    user_choice = list_deck_selection(mtg_format)

    deck_selection_execution(mtg_format, user_choice)
  end

  def self.valid_card_selection_choice?(user_input_string, deck)
    ['list decks', 'list formats', 'exit'].include?(user_input_string) ||
      deck.how_many(user_input_string).positive?
  end

  def self.prompt_and_get_card_selection_input(deck)
    user_input = ''

    until valid_card_selection_choice?(user_input, deck) 
      puts "Enter a card's name to get more info on the card, " +
           "#{'list decks'.colorize(:yellow)}' to see another deck, " +
           "'#{'list formats'.colorize(:yellow)}' to see another format, or " +
           "'#{'exit'.colorize(:yellow)}' to exit."
      puts 'What would you like to do?:'
      user_input = gets.strip.downcase
    end
    user_input
  end

  def self.execute_card_selection_choice(user_input, mtg_format, deck)
    if deck.how_many(user_input).positive?
      choose_card(deck.cards[deck.symbolize(user_input)], deck)
    elsif user_input == 'list decks'
      deck_selection_execution(mtg_format, list_deck_selection(mtg_format))
    elsif user_input == 'list formats'
      format_selection_execution(self.list_format_selection)
    elsif user_input == 'exit'
      goodbye
    end
  end

  def self.choose_decklist(deck)
    Scraper.scrape_decklist(deck) if deck.cards.nil?

    deck.print_deck

    execute_card_selection_choice(prompt_and_get_card_selection_input(deck), deck.mtg_format, deck)
  end

  def self.choose_card(card, deck)
    Scraper.scrape_card_info(card) if card.online_price.nil?

    card.display_detailed_card

    user_input = prompt_and_get_bottom_level_input(deck)

    execute_bottom_level_choice(user_input, deck)
  end
end
