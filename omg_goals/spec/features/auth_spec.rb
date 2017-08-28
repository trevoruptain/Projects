require 'spec_helper'
require 'rails_helper'

include AuthFeaturesHelper

feature 'the signup process' do
  scenario 'has a new user page' do
    visit new_user_url
    expect(page).to have_content 'New User'
  end

  feature 'signing up a user' do
    before(:each) do
      sign_up('coolguy3000')
    end
    scenario 'shows username on the homepage after signup' do
      expect(page).to have_content 'coolguy3000'
    end
  end
end

feature 'logging in' do
  before(:each) do
    user = User.new(username: 'coolguy3000', password: 'abc123')
    user.save
    login(user)
  end
  scenario 'shows username on the homepage after login' do
    expect(page).to have_content 'coolguy3000'
  end
end

feature 'logging out' do
  scenario 'begins with a logged out state' do
    visit('/users')
    expect(page).to have_content 'Sign In'
  end

  scenario 'doesn\'t show username on the homepage after logout' do
    user = User.new(username: 'coolguy3000', password: 'abc123')
    user.save
    login(user)
    click_button('Logout')
    expect(page).to_not have_content('coolguy3000')
  end
end
