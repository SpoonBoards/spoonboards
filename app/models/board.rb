class Board < ActiveRecord::Base
  belongs_to :user
  has_many :designs
  validates :user_id, presence: true

  def get_first_image
    target_design = self.designs.first
    if target_design == nil
      return "http://www.iconarchive.com/download/i88574/icons8/ios7/Messaging-Sad.ico"
    else
      target_image = target_design.get_json_for_design(target_design.spoonflower_id, target_design.id)[2]
    end
  end

  def post_board_to_pinterest(spoonflower_id, design_id)


    @response = HTTParty.get("https://api.pinterest.com/v1/boards/?access_token=AZ_oz4nDgBrMyexsrXLITBDgasJKFEQbib649EJDAHQqTKBGugAAAAA&name=Dinosaursdxd"})
    @results = display_items(@response, design_id)
  end

  # def generate_board
  #   HTTParty.post("https://api.pinterest.com/v1/boards/?access_token=#{PINTEREST_ACCESS_TOKEN}&fields=id%2C#{board.name}%2Curl")
  # end
end
