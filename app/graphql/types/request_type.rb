# frozen_string_literal: true

module Types
  class RequestType < Types::BaseObject
    field :id, ID, null: false
    field :user_id, Integer, null: false
    field :places, Integer, null: false
    field :room_class, String, null: false
    field :time_of_stay, Integer, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
