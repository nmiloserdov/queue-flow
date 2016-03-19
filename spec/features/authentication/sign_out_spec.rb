require 'rails_helper'

feature 'User sign out' do
  given(:user) { create :user }
  
  scenario 'signed in user try sign out' do
    visit root_path
    sign_in(user)
    expect(page).to have_content 'log out'
    click_link 'log out'
    expect(page).to have_content('Signed out successfully.')
  end 
  scenario 'non-signed in user try sign out' do
    visit root_path
    expect(page).not_to have_content('log out')
  end
end