# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'request policy', type: :request do
  let!(:user1) { User.create(email: 'test@gmail.com', password: '123456', authentication_token: 'huninhwewcce') }
  let!(:user2) { User.create(email: 'test2@gmail.com', password: '3363636', authentication_token: 'vsfgvsgsvdgdv') }
  let!(:user3) do
    User.create(email: 'test3@gmail.com', password: '5646546', authentication_token: 'gdhhfdhdfhfhf', admin: true)
  end
  let!(:request1) { Request.create(user: user1, places: 3, room_class: 'lux', time_of_stay: 4) }
  let!(:request2) { Request.create(user: user2, places: 2, room_class: 'normal', time_of_stay: 2) }
  describe 'scope' do
    context 'user authorization' do
      it 'raise not authorized error' do
        expect { Pundit.policy_scope(user1, Request) }.to raise_error(Pundit::NotAuthorizedError)
      end
    end
    context 'admin authorization' do
      it 'return all requests' do
        requests = Pundit.policy_scope(user3, Request)
        expect(requests).to eq(Request.all)
      end
    end
  end
end
