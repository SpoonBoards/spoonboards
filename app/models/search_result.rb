class SearchResult
  attr_reader :display_items

  def initialize(json)
    @results = display_items
  end

  def display_items
    @results.each do |r|
    end
  end
end
