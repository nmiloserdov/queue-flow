require 'rails_helper'

feature 'User create anwer' do
  
  given(:user)   { create :user }
  given(:answer) { create :answer }
  
  before do
    @question = Question.create attributes_for :question
  end
  
  scenario 'authenticated user create answer' do
    sign_in user
    visit question_path @question
    fill_in "Body", with: "another answer"
    click_on 'Add'
    expect(page.all('p.body-answer', text: "another answer")).not_to be_empty
  end
  
  scenario 'non-authentigicated user create answer' do
    
  end
    
end