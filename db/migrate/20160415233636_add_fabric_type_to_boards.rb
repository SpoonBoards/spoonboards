class AddFabricTypeToBoards < ActiveRecord::Migration
  def change
    add_column :boards, :fabric_type, :string
  end
end
