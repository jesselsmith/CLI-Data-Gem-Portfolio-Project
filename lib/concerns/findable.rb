module Concerns::Findable
  def find_by_name(name)
    all.find { |item| item.name == name }
  end
end
