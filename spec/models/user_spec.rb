require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#generate_new_authentication_token' do
    it 'generate new user with token' do
      user = User.create(email: 'test1@gmail.com', password: '123456')
      token = user.authentication_token
      expect(token).to_not eq(nil)
    end
    it 'generate different token' do
      user = User.create(email: 'test2@gmail.com', password: '123456', authentication_token: 'huninhwewcce')
      user.generate_new_authentication_token
      new_token = user.authentication_token
      expect(new_token).to_not eq('huninhwewcce')
    end
  end
end
