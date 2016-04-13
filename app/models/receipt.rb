class Receipt < ActiveRecord::Base
  belongs_to :cart
  has_many :cart_items
end
