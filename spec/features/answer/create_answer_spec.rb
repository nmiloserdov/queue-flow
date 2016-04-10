require_relative '../feature_helper'

feature 'User create anwer' do
  
  given(:user)   { create :user }
  given(:answer) { create :answer }
  
  before do
    @question = create(:question)
  end
  
  scenario 'authenticated user create answer', js: true do
    sign_in user
    visit question_path @question
    fill_in "Body", with: "another answer"
    click_on 'Add'
    within 'p.body-answer' do
      expect(page).to have_content('another answer')
    end
  end
  
  scenario 'non-authentigicated user create answer' do
    visit question_path @question
    expect(page).to have_content("You need to sign in or sign up before continuing")
  end
    
  scenario 'user try to create invalid answer', js: true do
    sign_in user
    visit question_path @question
    click_on 'Add'
    expect(page).to have_content("Body can't be blank.")
  end

end

