# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'requests query', type: :request do
  let!(:user1) { User.create(email: 'test@gmail.com', password: '123456', authentication_token: 'huninhwewcce') }
  let!(:user2) { User.create(email: 'test2@gmail.com', password: '3363636', authentication_token: 'vsfgvsgsvdgdv') }
  let!(:user3) do
    User.create(email: 'test3@gmail.com', password: '5646546', authentication_token: 'gdhhfdhdfhfhf', admin: true)
  end
  context 'admin authorization' do
    headers = { 'Authorization' => 'gdhhfdhdfhfhf' }
    it 'return all users' do
      query = '{users{email,admin}}'
      post('/graphql', params: { query: }, headers:)
      expect(JSON.parse(response.body)).to eq({ 'data' => { 'users' => [{ 'admin' => false, 'email' => 'test@gmail.com' },
                                                                        { 'admin' => false,
                                                                          'email' => 'test2@gmail.com' },
                                                                        { 'admin' => true,
                                                                          'email' => 'test3@gmail.com' }] } })
    end
  end
  context 'user authorization' do
    headers = { 'Authorization' => 'vsfgvsgsvdgdv' }
    it 'return No access' do
      query = '{users{email,admin}}'
      expect { post('/graphql', params: { query: }, headers:) }.to raise_error(Pundit::NotAuthorizedError)
    end
  end
end
