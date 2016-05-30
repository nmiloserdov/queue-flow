require_relative '../feature_helper'

feature 'Delete answer' do
  given(:user) { create(:user) }
  given(:foreign_answer) { create(:answer) }
  given(:answer) { create(:answer, user: user) }

  before do
    sign_in user
  end

  scenario "user dosen't delete not his answer" do
    visit question_path(foreign_answer.question)

    expect { page.find('.delete-answer-link') }
      .to raise_error Capybara::ElementNotFound
  end

  scenario "user delete his answer", js: true do
    visit question_path(answer.question)
    find('.delete-answer-link').trigger("click")
    within ".answers-container" do
      expect(page).not_to have_selector(".answer-#{answer.id}")
    end
  end
end
