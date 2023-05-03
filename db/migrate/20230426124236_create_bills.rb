# frozen_string_literal: true

class CreateBills < ActiveRecord::Migration[7.0]
  def change
    create_table :bills do |t|
      t.references :user, null: false, foreign_key: true
      t.references :room, null: false, foreign_key: true
      t.integer :cost, null: false
      t.timestamps
    end
  end
end
