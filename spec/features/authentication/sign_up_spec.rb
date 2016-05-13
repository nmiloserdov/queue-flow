require_relative '../feature_helper'

feature 'sign up user' do

  given(:user) { attributes_for :user }  
  
  before {
    visit new_user_registration_path
  }
  
  scenario 'sign up user with valid params' do
    fill_in "Email", with: user[:email]
    fill_in "Password", with: user[:password]    
    fill_in "Password confirmation", with: user[:password]    
    click_on 'Sign up'
    expect(page).to have_content("Welcome! You have signed up successfully.")
  end
  
  scenario 'sign up with empty params' do
    fill_in "Email", with: user[:email]    
    fill_in "Password", with: user[:password]
    click_on "Sign up"
    expect(page).to have_content("Password confirmation doesn't match Password")
  end
  
  scenario 'sign up user with existed email' do
    User.create(user)
    fill_in "Email", with: user[:email]
    fill_in "Password", with: user[:password]
    fill_in "Password confirmation", with: user[:password]
    click_on 'Sign up'
    expect(page).to have_content("Email has already been taken")
  end
  
end
