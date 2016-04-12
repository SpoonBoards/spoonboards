class Design < ActiveRecord::Base
  belongs_to :board
  belongs_to :cart_item

  def get_json_for_design(spoonflower_id, design_id)
    @response = HTTParty.get("https://api.spoonflower.com:443/design/#{spoonflower_id}", :headers => {"X-Auth-Token" => "#{ENV["SPOON_KEY"]}"})
    @results = display_items(@response, design_id)
  end


  def display_items(individual_items, design_id)
    item = []
    item << individual_items["results"][0]["id"]
    item << individual_items["results"][0]["name"]
    item << individual_items["results"][0]["thumbnailURL"]
    item << design_id
    return item
  end
end
