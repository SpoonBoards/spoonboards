class CartItem < ActiveRecord::Base
  belongs_to :cart
  has_many :designs

  def create_cart_item_from_design(design_properties)
    CartItem.create!(spoonflower_id: design_properties[0],
      design_name: design_properties[1],
      thumbnail_url: design_properties[2],
      design_id: design_properties[3],
      cart_id: design_properties[4])
  end
end
