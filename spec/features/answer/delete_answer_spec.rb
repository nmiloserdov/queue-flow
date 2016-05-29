require_relative '../feature_helper'

feature 'Delete answer' do
  given(:user) { create(:user) }
  given(:foreign_answer) { create(:answer) }
  given(:answer) { create(:answer, user: user) }

  before do
    sign_in user
  end

  scenario "user don't delete not his answer", js: true do
    visit question_path(foreign_answer.question)

    expect { page.find('.delete-answer-link') }
      .to raise_error Capybara::ElementNotFound
  end

  scenario "user delete his answer", js: true do
    visit question_path(answer.question) 
    save_and_open_page
    page.find('.delete-answer-link').click
    
    within ".answers-container" do
      expect(page).not_to have_content(answer.body)
    end
  end
end
