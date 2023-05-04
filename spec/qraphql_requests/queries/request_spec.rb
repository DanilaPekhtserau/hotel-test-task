# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'requests query', type: :request do
  let!(:user1) { User.create(email: 'test@gmail.com', password: '123456', authentication_token: 'huninhwewcce') }
  let!(:user2) { User.create(email: 'test2@gmail.com', password: '3363636', authentication_token: 'vsfgvsgsvdgdv') }
  let!(:user3) do
    User.create(email: 'test3@gmail.com', password: '5646546', authentication_token: 'gdhhfdhdfhfhf', admin: true)
  end
  let!(:request1) { Request.create(user: user1, places: 3, room_class: 'lux', time_of_stay: 4) }
  let!(:request2) { Request.create(user: user2, places: 2, room_class: 'normal', time_of_stay: 2) }
  context 'admin authorization' do
    headers = { 'Authorization' => 'gdhhfdhdfhfhf' }
    it 'return all requests' do
      query = '{requests{ userId,places,roomClass,timeOfStay}}'
      post('/graphql', params: { query: }, headers:)
      expect(response.body).to eq("{\"data\":{\"requests\":[{\"userId\":#{user1.id},\"places\":3,\"roomClass\":\"lux\",\"timeOfStay\":4},{\"userId\":#{user2.id},\"places\":2,\"roomClass\":\"normal\",\"timeOfStay\":2}]}}")
    end
    it 'return filtered requests' do
      query = '{requests(places: 2){ userId,places,roomClass,timeOfStay}}'
      post('/graphql', params: { query: }, headers:)
      expect(response.body).to eq("{\"data\":{\"requests\":[{\"userId\":#{user2.id},\"places\":2,\"roomClass\":\"normal\",\"timeOfStay\":2}]}}")
    end
    it 'return sorted requests' do
      query = '{requests(orderBy: "places"){ userId,places,roomClass,timeOfStay}}'
      post('/graphql', params: { query: }, headers:)
      expect(response.body).to eq("{\"data\":{\"requests\":[{\"userId\":#{user2.id},\"places\":2,\"roomClass\":\"normal\",\"timeOfStay\":2},{\"userId\":#{user1.id},\"places\":3,\"roomClass\":\"lux\",\"timeOfStay\":4}]}}")
    end
  end
  context 'user authorization' do
    headers = { 'Authorization' => 'vsfgvsgsvdgdv' }
    it 'return No access' do
      query = '{requests{ userId,places,roomClass,timeOfStay}}'
      expect { post('/graphql', params: { query: }, headers:) }.to raise_error(Pundit::NotAuthorizedError)
    end
  end
  context 'no authorization' do
    headers = { 'Authorization' => '' }
    it 'return User does not exist' do
      query = '{requests{ userId,places,roomClass,timeOfStay}}'
      post('/graphql', params: { query: }, headers:)
      expect(response.body).to include('User does not exist')
    end
  end
end
