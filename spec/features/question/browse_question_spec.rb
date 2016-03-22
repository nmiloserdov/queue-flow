require 'rails_helper'

feature 'User can brouse question', %q{
  Non-authenticated User can browse questions
  } do
   
  
  scenario 'user browse questions#index' do
    
    @questions = create_list(:question, 3) 

    visit questions_path
    
    @questions.each do |question| 
      expect(page).to have_content question.title
      expect(page).to have_content question.body
    end
  end
  
  scenario 'user browse question and answers for them' do
    question = create(:question)
    answers  = create_list(:answer, 3, question: question) 

    visit question_path question

    expect(page).to have_content question.title
    expect(page).to have_content question.body
    
    answers.each do |answer|
      expect(page).to have_content answer.body
    end
  end
  
end
