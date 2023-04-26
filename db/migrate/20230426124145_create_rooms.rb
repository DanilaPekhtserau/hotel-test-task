class CreateRooms < ActiveRecord::Migration[7.0]
  def change
    create_table :rooms do |t|
      t.integer :places, null: false, default: 1
      t.string :room_class, null: false
      t.integer :price, null: false
      t.timestamps
    end
  end
end
