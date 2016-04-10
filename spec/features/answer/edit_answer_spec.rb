require_relative '../feature_helper'

feature 'Edit answer' do

  given(:user) { create(:user) }
  given(:question) { create(:question) }
  given(:answer) { create(:answer, user: user, question: question) }
  given(:another_answer) { create(:answer, question: question)  }


  context "non-authenticated user" do

    scenario "try to edit answer" do
      visit question_path(answer.question)
      expect(page).to_not have_link 'edit'
    end
  end
  
  context "authenticated user" do
    
    before do
      sign_in user
      visit question_path(answer.question)
      expect(page).to have_link('edit')
      click_on 'edit'

    end
    
    scenario "edit his answer with valid params", js: true do  
      within ".answers-container" do
        fill_in 'Body', with: "updated answer"
        click_on 'update'
        expect(page).to have_content "updated answer"
      end
    end

    scenario "try to edit two answer", js: true do
      within ".answers-container" do
        expect(page).not_to have_content('edit')
      end
    end

    scenario "edit his answer with invalid params", js: true do
      within ".answers-container" do
        fill_in 'Body', with: ""
        click_on 'update'
        expect(page).to have_content("Body can't be blank.")
      end
    end
  end


end
