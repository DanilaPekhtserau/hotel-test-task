# frozen_string_literal: true

module Mutations
  class CreateUser < Mutations::BaseMutation
    argument :email, String, required: true
    argument :password, String, required: true
    argument :admin, Boolean, required: true

    field :user, Types::UserType, null: false

    def resolve(email:, password:, admin: false)
      user = User.new(email:, password:, admin:)

      return unless user.save

      {
        user:
      }
    end
  end
end
