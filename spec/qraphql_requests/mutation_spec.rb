require 'rails_helper'

RSpec.describe 'POST /graphql', type: :request do

  let!(:user1) { User.create(email: 'test@gmail.com', password: "123456", authentication_token: 'huninhwewcce') }
  let!(:user2) { User.create(email: 'test3@gmail.com', password: "3363636", authentication_token: 'gdhhfdhdfhfhf', admin: true) }

  context 'requests mutation' do
    it 'create request' do
      headers = { 'Authorization' => 'huninhwewcce' }
      query = "mutation{createRequest(input:{places: 1,roomClass: \"lux\",timeOfStay: 2}){request{userId,places,roomClass,timeOfStay}}}"
      post "/graphql", params: { query: query }, headers: headers
      expect(response.body).to eq("{\"data\":{\"createRequest\":{\"request\":{\"userId\":#{user1.id},\"places\":1,\"roomClass\":\"lux\",\"timeOfStay\":2}}}}")
    end
  end
  context 'bills mutation' do
    let!(:room1) { Room.create(places: 3, room_class: "normal", price: 40) }
    let!(:request1) { Request.create(user: user1, places: 3, room_class: 'lux', time_of_stay: 4) }
      headers = { 'Authorization' => 'gdhhfdhdfhfhf' }
      it 'create bill' do
        query = "mutation{createBill(input:{requestId: #{request1.id}, roomId: #{room1.id}}){bill{userId,roomId,cost}}}"
        post "/graphql", params: { query: query }, headers: headers
        expect(response.body).to eq("{\"data\":{\"createBill\":{\"bill\":{\"userId\":#{user1.id},\"roomId\":#{room1.id},\"cost\":160}}}}")
      end


    end
  end
