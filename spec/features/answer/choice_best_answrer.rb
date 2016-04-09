require_relative '../feature_helper'

feature 'User choice best answer', js: true do
  given(:user) { create :user }
  given(:question) { create :question, user: user }
  
  scenario 'user chouse best answer' do
    sign_in user
    create(:answer, question: question, user: user)
    visit question_path question
    within '.answer-container' do
      click_on 'best'
      expect(page).to have_selector('.best-answer-container')
    end
  end

end
