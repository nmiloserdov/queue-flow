require_relative '../feature_helper'

feature 'User sign in', %q{
  In order to be able to ask question
  As an user, i want to be able to sign in } do
    
  given(:user) { create :user }  
    
  scenario 'Registered user try to sign in' do
    sign_in(user)
    expect(page).to have_content 'Signed in successfully.'
    expect(current_path).to eq root_path
  end
  
  scenario 'Anregistred user try to sign in' do
    visit new_user_session_path
    fill_in "Email",    with: 'wrongexample.com'
    fill_in "Password", with: '12345678'
    click_on 'Log in'
    expect(page).to have_content 'Invalid email or password.'
    expect(current_path).to eq new_user_session_path
  end

  scenario 'With facebook' do
    Authorization.create(provider: 'facebook', uid: '123545', user: user)
    visit new_user_session_path
    click_on 'Sign in with Facebook'
    expect(page).to have_content 'Successfully authenticated from Facebook account.'
  end

  scenario 'With twitter' do
    Authorization.create(provider: 'tiwtter', uid: '123545', user: user)
    visit new_user_session_path
    click_on 'Sign in with Twitter'
    expect(page).to have_content 'Successfully authenticated from Twitter account.'
  end
end
