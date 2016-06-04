require_relative '../feature_helper'

feature 'Create comment' do
  
  given(:user)     { create :user }
  given(:comment)  { create :comment }
  given!(:question) { create :question }

  context "authenticated user" do
    scenario 'creates comment', js: true do
      sign_in(user)
      visit question_path(question)
      within '.question-basic' do
        click_on 'add comment'
        fill_in :body, with: comment.body
        click_on "add"
      end
      expect(page).to have_content comment.body
    end
  end
  
  context "non-authenticated user" do
    scenario 'not create comment' do
      visit question_path(question)
      within '.question-basic' do
        expect(page).not_to have_content("add comment")
      end
    end
  end
end
