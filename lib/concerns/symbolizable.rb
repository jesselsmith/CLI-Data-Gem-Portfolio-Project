module Concerns::Symbolizable
  # takes in a name string and converts it to a symbol
  def symbolize(name_string)
    # replaces all the spaces with underscores, downcases before converting
    name_string.gsub(/,?\s+/, '_').downcase.to_sym
  end
end
