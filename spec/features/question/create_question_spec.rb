require_relative '../feature_helper'

feature 'Create question', %q{
  In oreder to get answer from community
  as an authenticated user
  I want to be able to ask question } do
  
  given(:user) { create :user }

  scenario 'Authentificated user create question' do
    sign_in(user)
    visit questions_path
    click_on 'Ask question'
    fill_in 'Title', with: 'test title'
    fill_in 'Body',  with: 'test body'
    click_on 'Ask'

    expect(page).to have_content 'Your question successfully created.'
    expect(page).to have_content 'test title'
    expect(page).to have_content 'test body'
  end  
  
  scenario 'Non-authentificated user try create question' do
    visit questions_path
    click_on 'Ask question'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end
