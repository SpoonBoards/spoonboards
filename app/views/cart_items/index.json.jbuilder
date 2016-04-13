json.array!(@cart_items) do |cart_item|
  json.extract! cart_item, :id, :cart_id, :price, :quantity, :design_name, :design_id, :spoonflower_id, :thumbnail_url, :fabric_type, :purchased
  json.url cart_item_url(cart_item, format: :json)
end
