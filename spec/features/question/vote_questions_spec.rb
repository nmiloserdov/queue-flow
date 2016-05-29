require_relative '../feature_helper'

feature 'user votes question' do

  given(:user) { create(:user) }
  given(:question) { create(:question) }

  before do
    sign_in user
    visit question_path(question)
  end

  scenario 'vote up', js: true do
    page.find('.upvote-btn').click
    within ".question-rating-#{question.id}" do
      expect(page).to have_content "1"
    end
  end

  scenario 'vote down', js: true do
    evaluate_script  "document.getElementsByClassName"\
      "('downvote-btn')[0].click()"
    within '.question-cont' do
      expect(page).to have_content "-1"
    end
  end

  scenario "rollback vote", js: true do
    evaluate_script  "document.getElementsByClassName"\
      "('downvote-btn')[0].click()"
    evaluate_script  "document.getElementsByClassName"\
      "('upvote-btn')[0].click()"
    within '.question-cont' do
      expect(page).to have_content "0"
    end
  end
end
