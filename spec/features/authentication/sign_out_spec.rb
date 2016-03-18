require 'rails_helper'

feature 'User sign out' do
  given(:user) { create :user }
  
  scenario 'signed in user try sign out'
  
  scenario 'non-signed in user try sign out'
end