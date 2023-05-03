require 'rails_helper'

RSpec.describe 'bills query', type: :request do
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
  context 'user authorization' do
    headers = { 'Authorization' => 'huninhwewcce' }
    it 'return user\'s bills' do
      query = '{bills{ userId, roomId, cost}}'
      post('/graphql', params: { query: }, headers:)
      expect(response.body).to eq("{\"data\":{\"bills\":[{\"userId\":#{user1.id},\"roomId\":#{room1.id},\"cost\":140},{\"userId\":#{user1.id},\"roomId\":#{room2.id},\"cost\":164}]}}")
    end
  end
  context 'admin authorization' do
    headers = { 'Authorization' => 'gdhhfdhdfhfhf' }
    it 'return all bills' do
      query = '{bills{ userId, roomId, cost}}'
      post('/graphql', params: { query: }, headers:)
      expect(response.body).to eq("{\"data\":{\"bills\":[{\"userId\":#{user1.id},\"roomId\":#{room1.id},\"cost\":140},{\"userId\":#{user2.id},\"roomId\":#{room1.id},\"cost\":50},{\"userId\":#{user1.id},\"roomId\":#{room2.id},\"cost\":164}]}}")
    end
    it 'return filtered bills' do
      query = "{bills(clientId: #{user1.id}){ userId, roomId, cost}}"
      post('/graphql', params: { query: }, headers:)
      expect(response.body).to eq("{\"data\":{\"bills\":[{\"userId\":#{user1.id},\"roomId\":#{room1.id},\"cost\":140},{\"userId\":#{user1.id},\"roomId\":#{room2.id},\"cost\":164}]}}")
    end
    it 'return sorted requests' do
      query = '{bills(orderBy: "cost"){ userId, roomId, cost}}'
      post('/graphql', params: { query: }, headers:)
      expect(response.body).to eq("{\"data\":{\"bills\":[{\"userId\":#{user2.id},\"roomId\":#{room1.id},\"cost\":50},{\"userId\":#{user1.id},\"roomId\":#{room1.id},\"cost\":140},{\"userId\":#{user1.id},\"roomId\":#{room2.id},\"cost\":164}]}}")
    end
  end
  context 'no authorization' do
    headers = { 'Authorization' => '' }
    it 'return User does not exist' do
      query = '{bills{ userId, roomId, cost}}'
      post('/graphql', params: { query: }, headers:)
      expect(response.body).to include('User does not exist')
    end
  end
end
