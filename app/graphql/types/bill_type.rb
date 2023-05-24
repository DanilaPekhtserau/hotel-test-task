# frozen_string_literal: true

module Types
  class BillType < Types::BaseObject
    implements Interfaces::RecordInterface
    field :user_id, Integer, null: false
    field :room_id, Integer, null: false
    field :cost, Integer, null: false
  end
end
