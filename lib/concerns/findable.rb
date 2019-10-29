module Concerns::Findable
  def find_by_name(name)
    all.find { |item| item.name == name }
  end

  def find_or_create_by_name(name)
    # Or only executes the first element that evaluates to truthy, so if
    # something with that name already exists, that is returned, and if not,
    # then a new item with that name is created
    find_by_name(name) || create(name)
  end
end
