require_relative '../feature_helper'

feature 'user votes question' do

  given(:user)           { create(:user) }
  given(:question)       { create(:question) }
  given(:owner_question) { create(:question, user: user) }


  context "user question" do
    before do
      sign_in user
      visit question_path(question)
    end

    scenario 'vote up', js: true do
      find('.upvote-btn').click
      within '.question-rating-1' do
        expect(page).to have_content "1"
      end
    end

    scenario 'vote down', js: true do
      find('.downvote-btn').click
      within '.rang-container' do
        expect(page).to have_content "-1"
      end
    end

    scenario "rollback vote", js: true do
      find('.upvote-btn').click
      find('.downvote-btn').click
      within '.question-cont' do
        expect(page).to have_content "0"
      end
    end
  end

  scenario "user cant vote for his question", js: true do
    sign_in user
    visit question_path(owner_question)
    within '.question-cont' do
      find('.upvote-btn').click
    end
    expect(page).to have_content "Вы не можете голосовать за себя"
  end
end
