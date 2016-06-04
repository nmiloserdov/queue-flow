require_relative '../feature_helper'

feature 'Create comment' do
  
  given(:user)      { create :user }
  given(:comment)   { create :comment }
  given!(:question) { create :question }

  scenario 'Authentificated user create question', js: true do
    sign_in(user)
    visit questions_path(question)
    within '.question-basic' do
      click_on 'add comment'
      fill_in :body, with: comment.body
      click_on "add"
      expect(page).to have_content comment.body
    end
  end  
  
  scenario 'Non-authentificated user try create question' do
    visit questions_path
    within '.question-basic' do
      expect(page).not_to have_content("add comment")
    end
  end
end
