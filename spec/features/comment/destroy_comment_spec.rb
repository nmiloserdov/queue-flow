require_relative '../feature_helper'

feature 'Delete comment' do
  
  given(:user)      { create :user }
  given!(:question) { create :question }
  given(:comment)   { create :comment, commentable: question }

  scenario 'Authentificated user create question', js: true do
    sign_in(user)
    visit questions_path(question)
    within '.question-basic' do
      click_on 'delete'
      expect(page).not_to have_content(comment.body)
    end
  end  
  
  scenario 'Non-authentificated user try create question' do
    visit questions_path
    within '.question-basic' do
      expect(page).not_to have_content("delete")
    end
  end
end
