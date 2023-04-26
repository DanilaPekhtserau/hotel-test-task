class CreateRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :requests do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :places, null: false, default: 1
      t.string :room_class, null: false
      t.integer :time_of_stay, null:false, default: 1
      t.timestamps
    end
  end
end
