# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Bill, type: :model do
  describe '#get_cost' do
    let!(:user) { User.create(email: 'test@gmail.com', password: '123456', authentication_token: 'huninhwewcce') }
    let!(:room) { Room.create(places: 3, room_class: 'normal', price: 40) }
    let!(:request) { Request.create(user:, places: 3, room_class: 'lux', time_of_stay: 4) }
    it 'calculate cost' do
      bill = Bill.create(room:, user:, cost: Bill.get_cost(room.id, request.id))
      expect(bill.cost).to eq(160)
    end
  end
end
