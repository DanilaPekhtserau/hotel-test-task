# frozen_string_literal: true

class AddAuthenticationTokenToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :authentication_token, :string, unique: true
  end
end
