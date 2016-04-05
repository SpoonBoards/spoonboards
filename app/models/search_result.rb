class SearchResult
  attr_reader :parsed_results

  def initialize(individual_items)
    @parsed_results = display_items(individual_items)
  end

  def display_items(individual_items)
    individual_items.first
  end
end
