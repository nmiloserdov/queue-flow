require_relative '../feature_helper'

feature "User delete answer" do
  
  given(:user)     { create(:user) }
  given(:question) { create(:question) }
  
  
  
  scenario "user delete his question", js: true do
    sign_in(user)
    visit new_question_path
    fill_in "Title", with: question.title
    fill_in "Body",  with: question.body
    click_on 'Ask'
    page.find('.delete-question-link').trigger("click")
    expect(page).to have_content("Your question successfully deleted.")
  end
  
  scenario "user delete not his question" do
    sign_in(user)
    question = create(:question)
    visit question_path(question)
    expect(page).not_to have_link ".delete-question-link"
  end
  
end
