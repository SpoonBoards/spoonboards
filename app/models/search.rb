class Search
  attr_reader :results

  def initialize(search_term)
    @response = HTTParty.get("https://api.spoonflower.com/design/search?#{search_term}", :headers => {"X-Auth-Token" => "#{ENV["SPOON_KEY"]}"})
    @results = calculate_results
  end

  def calculate_results
    results = []
    @response["results"][0]["results"].each do |json|
      results << SearchResult.new(json)
    end
    results
  end
end
