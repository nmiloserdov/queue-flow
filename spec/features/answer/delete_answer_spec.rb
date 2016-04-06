require_relative '../feature_helper'

feature 'Delete answer' do
  given(:user) { create(:user) }
  given(:foreign_answer) { create(:answer) }
  given(:answer) { create(:answer, user: user) }

  before do
    sign_in user
  end

  scenario "user don't delete not his question", js: true do
    visit question_path(foreign_answer.question)

    within ".answer-#{foreign_answer.id}" do
      expect(page).not_to have_link 'delete'
    end
  end

  scenario "user delete his question", js: true do
    # я не могу понять почему тест фейлится 
    # в интерфейсе с такими же шагами все работает
    # трейс ошибки:
    # expected not to find text "test answer" in "user1 test answer edit delete"

    visit question_path(answer.question) 

    within ".answer-#{answer.id}" do
      click_link "delete"
    end
    
    within ".answer-cont" do
      expect(page).not_to have_content(answer.body)
    end
  end
end
