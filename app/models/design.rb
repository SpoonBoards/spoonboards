class Design < ActiveRecord::Base
  belongs_to :board


  def get_json_for_design(spoonflower_id)
    @response = HTTParty.get("https://api.spoonflower.com:443/design/#{spoonflower_id}", :headers => {"X-Auth-Token" => "#{ENV["SPOON_KEY"]}"})
    @results = display_items(@response)
  end

  def board_display
    results = []
    @response["results"].each do |json|
    byebug
    end
  end

  def display_items(individual_items)
    item = []
    item << individual_items["results"][0]["id"]
    item << individual_items["results"][0]["name"]
    item << individual_items["results"][0]["thumbnailURL"]
    return item
  end

end
