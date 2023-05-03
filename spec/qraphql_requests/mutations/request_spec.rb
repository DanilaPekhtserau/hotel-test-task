require 'rails_helper'

RSpec.describe 'requests mutation', type: :request do
  let!(:user1) { User.create(email: 'test@gmail.com', password: '123456', authentication_token: 'huninhwewcce') }
  let!(:user2) do
    User.create(email: 'test3@gmail.com', password: '3363636', authentication_token: 'gdhhfdhdfhfhf', admin: true)
  end

  context 'user authorization' do
    it 'create request' do
      headers = { 'Authorization' => 'huninhwewcce' }
      query = 'mutation{createRequest(input:{places: 1,roomClass: "lux",timeOfStay: 2}){request{userId,places,roomClass,timeOfStay}}}'
      post('/graphql', params: { query: }, headers:)
      expect(response.body).to eq("{\"data\":{\"createRequest\":{\"request\":{\"userId\":#{user1.id},\"places\":1,\"roomClass\":\"lux\",\"timeOfStay\":2}}}}")
    end
  end
  context 'admin authorization' do
    it 'create request' do
      headers = { 'Authorization' => 'gdhhfdhdfhfhf' }
      query = 'mutation{createRequest(input:{places: 1,roomClass: "lux",timeOfStay: 2}){request{userId,places,roomClass,timeOfStay}}}'
      post('/graphql', params: { query: }, headers:)
      expect(response.body).to eq("{\"data\":{\"createRequest\":{\"request\":{\"userId\":#{user2.id},\"places\":1,\"roomClass\":\"lux\",\"timeOfStay\":2}}}}")
    end
  end
  context 'no authorization' do
    it 'return User does not exist' do
      headers = { 'Authorization' => '' }
      query = 'mutation{createRequest(input:{places: 1,roomClass: "lux",timeOfStay: 2}){request{userId,places,roomClass,timeOfStay}}}'
      post('/graphql', params: { query: }, headers:)
      expect(response.body).to include('User does not exist')
    end
  end
end
