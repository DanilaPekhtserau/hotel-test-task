# frozen_string_literal: true

class User < ApplicationRecord
  has_many :bills
  has_many :requests
  acts_as_token_authenticatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def generate_new_authentication_token
    token = User.generate_unique_secure_token
    update_attribute(:authentication_token, token)
  end
end
