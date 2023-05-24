# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'users mutation', type: :request do
  it 'create user' do
    query = 'mutation{createUser(input:{email: "test@gmail.com", password: "123456", admin: false}){user{id,email, admin}}}'
    post('/graphql', params: { query: }, headers:)
    expect(JSON.parse(response.body)).to eq({ 'data' => { 'createUser' => { 'user' => { 'email' => 'test@gmail.com',
                                                                                        'id' => User.last.id.to_s,
                                                                                        'admin' => false } } } })
  end
  it 'create admin user' do
    query = 'mutation{createUser(input:{email: "test2@gmail.com", password: "123456", admin: true}){user{id,email, admin}}}'
    post('/graphql', params: { query: }, headers:)
    expect(JSON.parse(response.body)).to eq({ 'data' => { 'createUser' => { 'user' => { 'email' => 'test2@gmail.com',
                                                                                        'id' => User.last.id.to_s,
                                                                                        'admin' => true } } } })
  end
end
