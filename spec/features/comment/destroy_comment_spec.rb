require_relative '../feature_helper'

feature 'Delete comment' do
  
  given(:user)      { create :user }
  given!(:question) { create :question }
  given!(:comment)  { create :comment, commentable: question, user: user }

  context 'authentificated user' do
    scenario 'delete comment', js: true do
      sign_in(user)
      visit question_path(question)
      within '.comments-section' do
        click_on 'delete'
        sleep(5)
        expect(page).not_to have_content(comment.body)
      end
    end  
  end
  
  context 'non-authentificated user' do
    scenario 'not delete comment', js: true do
      visit question_path(question)
      within '.comments-section' do
        expect(page).not_to have_content("delete")
      end
    end
  end
end
