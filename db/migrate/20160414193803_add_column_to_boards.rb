class AddColumnToBoards < ActiveRecord::Migration
  def change
    add_column :boards, :marked_private, :boolean

  end
end
