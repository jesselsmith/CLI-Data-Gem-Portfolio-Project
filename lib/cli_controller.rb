class CliController

  MTG_FORMAT_LIST = %w[standard modern pioneer pauper legacy vintage].freeze
  @@format_already_scraped = MTG_FORMAT_LIST.map{ false }

  def self.greeting
    puts 'Welcome to M:tG Metagame Scraper!'
  end

  def self.list_format_menu
    puts 'Select an option from the list below:'
    MTG_FORMAT_LIST.each.with_index(1) do |mtg_format, i|
      puts "#{i} Show me the top 12 #{mtg_format.capitalize} decks."
    end
    user_input = ''
    until valid_format_menu_choice?(user_input)
      puts "What would you like to do? [type 1-#{MTG_FORMAT_LIST.size} or 'exit' to exit]:"
      user_input = gets.strip.downcase
    end
    user_input
  end

  def self.valid_format_menu_choice?(input_string)
    input_string == 'exit' ||
      (1..(MTG_FORMAT_LIST.size)).include?(user_choice.to_i) ||
      MTG_FORMAT_LIST.include?(input_string)
  end

  def self.format_menu_execution(user_choice)
    if (1..(MTG_FORMAT_LIST.size)).include?(user_choice.to_i)
      scrape_format(MTG_FORMAT_LIST[user_choice.to_i - 1])
    elsif MTG_FORMAT_LIST.include?(user_choice)
      scrape_format(user_choice)
    elsif user_choice == 'exit'
      goodbye
    end
  end

  def self.goodbye
    puts 'Thanks for using M:tG Format Scraper! Goodbye!'
  end

  def self.start
    greeting
    user_choice = list_format_menu
    format_menu_execution(user_choice)
  end

  def self.scrape_format(mtg_format_string)
    unless @@format_already_scraped[MTG_FORMAT_LIST.find_index(mtg_format_string)]
  end
  
end
