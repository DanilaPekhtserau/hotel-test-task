# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'bills mutation', type: :request do
  let!(:user1) { User.create(email: 'test@gmail.com', password: '123456', authentication_token: 'huninhwewcce') }
  let!(:user2) do
    User.create(email: 'test3@gmail.com', password: '3363636', authentication_token: 'gdhhfdhdfhfhf', admin: true)
  end
  let!(:room1) { Room.create(places: 3, room_class: 'normal', price: 40) }
  let!(:request1) { Request.create(user: user1, places: 3, room_class: 'lux', time_of_stay: 4) }
  context 'admin authorization' do
    headers = { 'Authorization' => 'gdhhfdhdfhfhf' }
    it 'create bill' do
      query = "mutation{createBill(input:{requestId: #{request1.id}, roomId: #{room1.id}}){bill{userId,roomId,cost}}}"
      post('/graphql', params: { query: }, headers:)
      expect(JSON.parse(response.body)).to eq({ 'data' => { 'createBill' => { 'bill' => { 'cost' => 160,
                                                                                          'roomId' => room1.id, 'userId' => user1.id } } } })
    end
  end
  context 'user authorization' do
    headers = { 'Authorization' => 'huninhwewcce' }
    it 'return No access' do
      query = "mutation{createBill(input:{requestId: #{request1.id}, roomId: #{room1.id}}){bill{userId,roomId,cost}}}"
      expect { post('/graphql', params: { query: }, headers:) }.to raise_error(Pundit::NotAuthorizedError)
    end
  end
  context 'no authorization' do
    headers = { 'Authorization' => '' }
    it 'return User does not exist' do
      query = "mutation{createBill(input:{requestId: #{request1.id}, roomId: #{room1.id}}){bill{userId,roomId,cost}}}"
      post('/graphql', params: { query: }, headers:)
      expect(response.body).to include('User does not exist')
    end
  end
end
