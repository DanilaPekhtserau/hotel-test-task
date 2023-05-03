require 'rails_helper'

RSpec.describe 'bills mutation', type: :request do
  let!(:user1) { User.create(email: 'test@gmail.com', password: "123456", authentication_token: 'huninhwewcce') }
  let!(:user2) { User.create(email: 'test3@gmail.com', password: "3363636", authentication_token: 'gdhhfdhdfhfhf', admin: true) }
  let!(:room1) { Room.create(places: 3, room_class: "normal", price: 40) }
  let!(:request1) { Request.create(user: user1, places: 3, room_class: 'lux', time_of_stay: 4) }
  context 'admin authorization' do
    headers = { 'Authorization' => 'gdhhfdhdfhfhf' }
    it 'create bill' do
      query = "mutation{createBill(input:{requestId: #{request1.id}, roomId: #{room1.id}}){bill{userId,roomId,cost}}}"
      post "/graphql", params: { query: query }, headers: headers
      expect(response.body).to eq("{\"data\":{\"createBill\":{\"bill\":{\"userId\":#{user1.id},\"roomId\":#{room1.id},\"cost\":160}}}}")
    end
  end
  context 'user authorization' do
    headers = { 'Authorization' => 'huninhwewcce' }
    it 'return No access' do
      query = "mutation{createBill(input:{requestId: #{request1.id}, roomId: #{room1.id}}){bill{userId,roomId,cost}}}"
      post "/graphql", params: { query: query }, headers: headers
      expect(response.body).to include("No access")
    end
  end
  context 'no authorization' do
    headers = { 'Authorization' => '' }
    it 'return User does not exist' do
      query = "mutation{createBill(input:{requestId: #{request1.id}, roomId: #{room1.id}}){bill{userId,roomId,cost}}}"
      post "/graphql", params: { query: query }, headers: headers
      expect(response.body).to include("User does not exist")
    end
  end
end