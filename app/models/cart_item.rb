class CartItem < ActiveRecord::Base
  belongs_to :cart
  has_many :designs
end
