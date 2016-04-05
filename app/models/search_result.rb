class SearchResult
  attr_reader :parsed_results

  def initialize(individual_items)
    @parsed_results = display_items(individual_items)
  end

  def display_items(individual_items)
    item = []
    item << individual_items.first.second
    item << individual_items.as_json["name"]
    item << individual_items.as_json["thumbnail_url"]
    return item
  end
end
