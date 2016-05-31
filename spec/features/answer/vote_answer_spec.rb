require_relative '../feature_helper'

feature 'user votes answer' do

  given(:user)         { create(:user) }
  given(:answer)       { create(:answer) }
  given(:owner_answer) { create(:answer, user: user) }

  context "user answer" do
    before do
      sign_in user
      visit question_path(answer.question)
    end

    scenario 'vote up', js: true do
      within '.answers-container' do
        find('.upvote-btn').click
        expect(page).to have_content "1"
      end
    end

    scenario 'vote down', js: true do
      within '.answers-container' do
        find('.downvote-btn').click
        expect(page).to have_content "-1"
      end
    end

    scenario "rollback vote", js: true do
      within '.answers-container' do
        find('.downvote-btn').click
        find('.upvote-btn').click
        expect(page).to have_content "0"
      end
    end
  end

  scenario "user cant vote for his answer" do
    sign_in user
    visit question_path(owner_answer.question)
    within '.answers-container' do
      find('.upvote-btn').click
      expect(page).to have_content "Вы не можете голосовать за себя"
    end
  end
end
