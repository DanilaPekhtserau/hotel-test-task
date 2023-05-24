# frozen_string_literal: true

module Types
  module Interfaces
    module RecordInterface
      include GraphQL::Schema::Interface

      field :id, ID, null: false
      field :created_at, GraphQL::Types::ISO8601DateTime, null: false
      field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    end
  end
end
