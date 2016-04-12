class Cart < ActiveRecord::Base
  belongs_to :user
  has_many :cart_items
  validates :user_id, presence: true



end
