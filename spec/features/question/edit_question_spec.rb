require_relative '../feature_helper'

feature 'user edit question' do
  
  given(:user) { create(:user) }
  given(:question) { create(:question, user: user) }

  before do
    sign_in user
    visit question_path(question)
    click_on "edit"
  end
  scenario "user edit question" , js: true do
   within '.edit-question-form' do
     fill_in "Title", with: "new title"
     fill_in "Body",  with: "new body"
     click_on "update"
   end
   expect(page).to have_content("new title")
   expect(page).to have_content("new body")
  end

  scenario 'with invalid params', js: true do
    within '.edit-question-form' do
      fill_in 'Title', with: ""
      fill_in 'Body',  with: ""
      click_on 'update'
    end
    expect(page).to have_content("Title can't be blank.")
    expect(page).to have_content("Body can't be blank.")
  end
  

end