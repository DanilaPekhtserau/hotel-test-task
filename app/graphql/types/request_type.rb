# frozen_string_literal: true

module Types
  class RoomClassEnum < GraphQL::Schema::Enum
    value 'standart'
    value 'deluxe'
    value 'suite'
  end

  class RequestType < Types::BaseObject
    implements Interfaces::RecordInterface
    field :user_id, Integer, null: false
    field :places, Integer, null: false
    field :room_class, RoomClassEnum, null: false
    field :time_of_stay, Integer, null: false
  end
end
