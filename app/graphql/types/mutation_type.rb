# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :create_request, mutation: Mutations::CreateRequest
    field :create_bill, mutation: Mutations::CreateBill
    field :create_user, mutation: Mutations::CreateUser
  end
end
