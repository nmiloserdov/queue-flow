require_relative '../feature_helper'

feature 'user votes question' do

  given(:user) { create(:user) }
  given(:question) { create(:question, user: user) }

  before do
    sign_in user
    visit question_path(question)
  end

  scenario 'vote up' do
    page.find(".upvote-btn").click
    expect(page).to have_content "1"
  end

  scenario 'vote down' do
    page.find(".downvote-btn").click
    expect(page).to have_content "-1"
  end

  scenario "rollback vote" do
    page.find(".upvote-btn").click
    page.find(".downvote-btn").click
    expect(page).to have_content "0"
  end
end
