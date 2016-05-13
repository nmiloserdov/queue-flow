require_relative '../feature_helper'

feature 'User choice best answer', js: true do
  given(:user) { create :user }
  given(:question) { create :question, user: user }
  given(:answer) { create(:answer, user: user, question: question) }
  given(:another_answer) { create(:answer, user: user, question: question) }

  scenario 'user choise best answer' do
    sign_in user
    visit question_path(answer.question)
    within '.answers-container' do
      click_on 'best'
      expect(page).to have_selector('.best-answer-container')
    end
  end

  scenario 'user choice best answer when choise enother', js: true do
    answer.save
    another_answer.save

    sign_in user
    visit question_path(answer.question)

    within ".answers-container .answer-#{answer.id}" do
      click_on 'best'
    end

    within ".answer-#{another_answer.id}" do
      click_on 'best'
    end
    expect(page).to have_selector('.best-answer-container', count: 1)
  end

end
