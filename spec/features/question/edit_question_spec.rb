require_relative '../feature_helper'

feature 'user edit question' do
  
  given(:user) { create(:user) }
  given(:question) { create(:question, user: user) }

  context 'with valid params' do

    scenario "user edit question" , js: true do
     sign_in user
     visit question_path(question)
     click_on "edit"

     fill_in "Title", with: "new title"
     fill_in "Body",  with: "new body"
     click_on "update"
     save_and_open_page
     expect(page).to have_content("new title")
     expect(page).to have_content("new body")
    end

  end

  context 'with invalid params'
  

end
