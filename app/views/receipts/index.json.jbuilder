json.array!(@receipts) do |receipt|
  json.extract! receipt, :id, :cart_item_id, :city, :adr_1, :adr_2, :state, :zip, :name, :price
  json.url receipt_url(receipt, format: :json)
end
