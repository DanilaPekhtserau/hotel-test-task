# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'bill policy', type: :request do
  let!(:user1) { User.create(email: 'test@gmail.com', password: '123456', authentication_token: 'huninhwewcce') }
  let!(:user2) { User.create(email: 'test2@gmail.com', password: '3363636', authentication_token: 'vsfgvsgsvdgdv') }
  let!(:user3) do
    User.create(email: 'test3@gmail.com', password: '5646546', authentication_token: 'gdhhfdhdfhfhf', admin: true)
  end
  let!(:room1) { Room.create(places: 1, room_class: 'lux', price: 60) }
  let!(:room2) { Room.create(places: 3, room_class: 'normal', price: 40) }
  let!(:bill1) { Bill.create(user: user1, room: room1, cost: 140) }
  let!(:bill2) { Bill.create(user: user2, room: room1, cost: 50) }
  let!(:bill3) { Bill.create(user: user1, room: room2, cost: 164) }
  describe 'scope' do
    context 'user authorization' do
      it 'return user\'s bills' do
        bills = Pundit.policy_scope(user1, Bill)
        expect(bills).to eq(Bill.where(user_id: user1.id))
      end
    end
    context 'admin authorization' do
      it 'return all bills' do
        bills = Pundit.policy_scope(user3, Bill)
        expect(bills).to eq(Bill.all)
      end
    end
  end
  describe 'create?' do
    context 'user authorization' do
      it 'raise not authorized error' do
        expect { Pundit.authorize(user1, Bill, :create?) }.to raise_error(Pundit::NotAuthorizedError)
      end
    end
  end
end
