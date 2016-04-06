class Board < ActiveRecord::Base
  belongs_to :user
  has_many :designs
  validates :user_id, presence: true




end
