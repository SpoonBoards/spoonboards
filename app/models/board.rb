class Board < ActiveRecord::Base
  belongs_to :user
  has_many :designs
  validates :user_id, presence: true
  scope :write_public, -> { where(session[:user_id] = user.id)}

  def get_first_image
    target_design = self.designs.first
    if target_design == nil
      return "http://www.iconarchive.com/download/i88574/icons8/ios7/Messaging-Sad.ico"
    else
      target_image = target_design.get_json_for_design(target_design.spoonflower_id, target_design.id)[2]
    end
  end
end
