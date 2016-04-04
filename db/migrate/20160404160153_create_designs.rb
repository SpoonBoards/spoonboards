class CreateDesigns < ActiveRecord::Migration
  def change
    create_table :designs do |t|
      t.integer :board_id
      t.integer :spoonflower_id

      t.timestamps null: false
    end
  end
end
