require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:password_digest) }
  it { should validate_presence_of(:session_token) }

  subject(:user) do
    User.create!(
    username: "Taconova",
    password: "abc123")
  end

  it 'encrypts the password and adds it to the password digest' do
    expect(user.password_digest).to_not eq(nil)
  end

  it 'can look up a user by username and password' do
    user.save
    expect(User.find_by_credentials('Taconova', 'abc123').username).to eq('Taconova')
  end

  it 'ensures that a user has a session token' do
    expect(user.session_token).to_not eq(nil)
  end

  it 'can reset a users session token' do
    session_token = user.session_token
    user.reset_token!

    expect(user.session_token).to_not eq(session_token)
  end
end
