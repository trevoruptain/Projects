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
    expect(User.first.password_digest).to_not eq(nil)
  end

  it 'can look up a user by username and password' do
    expect(User.find_by_credentials('Taconova', 'abc123').name).to eq('Taconova')
  end

  it 'ensures that a user has a session token' do
    expect(User.first.session_token).to_not eq(nil)
  end

  it 'can reset a users session token' do
    session_token = User.first.session_token
    User.first.reset_session_token!

    expect(User.first.session_token).to_not eq(session_token)
  end
end
