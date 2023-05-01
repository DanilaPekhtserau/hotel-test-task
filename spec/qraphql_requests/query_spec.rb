require 'rails_helper'

RSpec.describe 'POST /graphql', type: :request do
  let!(:user1) { User.create(email: 'test@gmail.com', password: "123456", authentication_token: 'huninhwewcce') }
  let!(:user2) { User.create(email: 'test2@gmail.com', password: "3363636", authentication_token: 'vsfgvsgsvdgdv') }
  let!(:user3) { User.create(email: 'test3@gmail.com', password: "3363636", authentication_token: 'gdhhfdhdfhfhf', admin: true) }

  context 'requests query' do
    let!(:request1) { Request.create(user: user1, places: 3, room_class: 'lux', time_of_stay: 4) }
    let!(:request2) { Request.create(user: user2, places: 2, room_class: 'normal', time_of_stay: 2) }
    headers = { 'Authorization' => 'gdhhfdhdfhfhf' }
    it 'return all requests' do
      query = "{requests{ userId,places,roomClass,timeOfStay}}"
      post "/graphql", params: { query: query }, headers: headers
      expect(response.body).to eq("{\"data\":{\"requests\":[{\"userId\":#{user1.id},\"places\":3,\"roomClass\":\"lux\",\"timeOfStay\":4},{\"userId\":#{user2.id},\"places\":2,\"roomClass\":\"normal\",\"timeOfStay\":2}]}}")
    end
    it 'return filtered requests' do
      query = "{requests(places: 2){ userId,places,roomClass,timeOfStay}}"
      post "/graphql", params: { query: query }, headers: headers
      expect(response.body).to eq("{\"data\":{\"requests\":[{\"userId\":#{user2.id},\"places\":2,\"roomClass\":\"normal\",\"timeOfStay\":2}]}}")
    end
    it 'return sorted requests' do
      query = "{requests(orderBy: \"places\"){ userId,places,roomClass,timeOfStay}}"
      post "/graphql", params: { query: query }, headers: headers
      expect(response.body).to eq("{\"data\":{\"requests\":[{\"userId\":#{user2.id},\"places\":2,\"roomClass\":\"normal\",\"timeOfStay\":2},{\"userId\":#{user1.id},\"places\":3,\"roomClass\":\"lux\",\"timeOfStay\":4}]}}")
    end
  end

  context 'bills query' do
    let!(:room1) { Room.create(places: 1, room_class: "lux", price: 60) }
    let!(:room2) { Room.create(places: 3, room_class: "normal", price: 40) }
    let!(:bill1) { Bill.create(user: user1, room: room1, cost: 140) }
    let!(:bill2) { Bill.create(user: user2, room: room1, cost: 50) }
    let!(:bill3) { Bill.create(user: user1, room: room2, cost: 164) }
    context 'user access' do
      headers = { 'Authorization' => 'huninhwewcce' }
      it 'return user\'s bills' do
        query = "{bills{ userId, roomId, cost}}"
        post "/graphql", params: { query: query }, headers: headers
        expect(response.body).to eq("{\"data\":{\"bills\":[{\"userId\":#{user1.id},\"roomId\":#{room1.id},\"cost\":140},{\"userId\":#{user1.id},\"roomId\":#{room2.id},\"cost\":164}]}}")
      end
    end
    context 'admin access' do
      headers = { 'Authorization' => 'gdhhfdhdfhfhf' }
      it 'return all bills' do
        query = "{bills{ userId, roomId, cost}}"
        post "/graphql", params: { query: query }, headers: headers
        expect(response.body).to eq("{\"data\":{\"bills\":[{\"userId\":#{user1.id},\"roomId\":#{room1.id},\"cost\":140},{\"userId\":#{user2.id},\"roomId\":#{room1.id},\"cost\":50},{\"userId\":#{user1.id},\"roomId\":#{room2.id},\"cost\":164}]}}")
      end
      it 'return filtered bills' do
        query = "{bills(clientId: #{user1.id}){ userId, roomId, cost}}"
        post "/graphql", params: { query: query }, headers: headers
        expect(response.body).to eq("{\"data\":{\"bills\":[{\"userId\":#{user1.id},\"roomId\":#{room1.id},\"cost\":140},{\"userId\":#{user1.id},\"roomId\":#{room2.id},\"cost\":164}]}}")
      end
      it 'return sorted requests' do
        query = "{bills(orderBy: \"cost\"){ userId, roomId, cost}}"
        post "/graphql", params: { query: query }, headers: headers
        expect(response.body).to eq("{\"data\":{\"bills\":[{\"userId\":#{user2.id},\"roomId\":#{room1.id},\"cost\":50},{\"userId\":#{user1.id},\"roomId\":#{room1.id},\"cost\":140},{\"userId\":#{user1.id},\"roomId\":#{room2.id},\"cost\":164}]}}")
      end
    end
  end
end