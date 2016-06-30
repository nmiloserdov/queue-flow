require_relative '../feature_helper'

feature 'User subsirbe to question' do

  given(:user)     { create(:user) }
  given(:question) { create(:question) }

  context 'non-atthenticated user' do

    scenario 'Not subsribes to question' do
      visit question_path(question)
      expect(page).not_to have_content("subscribe") 
    end
  end

  context 'authenticated user' do

    scenario 'Substibe to question', js: true do
      sign_in(user)
      visit question_path(question)

      within '.question-cont' do
        click_on 'subscribe'
        expect(body).to have_content 'unsubscribe'
      end
    end

    scenario 'Unsubscribe from question', js: true do
      sign_in(user)
      create(:subscription, user: user, question: question)
      visit question_path(question)

      within '.question-cont' do
        click_on 'unsubscribe'
        expect(body).to have_content 'subscribe'
      end
    end
  end
end

