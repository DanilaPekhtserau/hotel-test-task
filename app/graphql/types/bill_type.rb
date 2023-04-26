# frozen_string_literal: true

module Types
  class BillType < Types::BaseObject
    field :id, ID, null: false
    field :user_id, Integer, null: false
    field :room_id, Integer, null: false
    field :cost, Integer, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
