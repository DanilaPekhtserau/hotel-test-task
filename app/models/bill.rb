# frozen_string_literal: true

class Bill < ApplicationRecord
  belongs_to :user
  belongs_to :room

  def self.get_cost(room_id, request_id)
    room = Room.find(room_id)
    request = Request.find(request_id)
    room.price * request.time_of_stay
  end
end
