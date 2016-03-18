require 'rails_helper'

feature 'User can brouse question', %q{
  Non-authenticated User can browse questions
  } do
   
  
  scenario 'user browse questions#index' do

    3.times { Question.create( attributes_for :question) }
  
    visit questions_path
  
    expect(page.all('div.title-question').count).to eq 3
    expect(page.all('div.body-question').count).to eq 3
  end
  
  scenario 'user browse question and answers for them' do
    question = Question.create( attributes_for :question )
    
    3.times { Answer.create( attributes_for :answer, 
                              question_id: question.id ) }
    
    visit question_path question
    
    expect(page.all('h1.title-question', text: question.title))
                                             .not_to be_empty
    expect(page.all('p.body-question', text: question.body))
                                          .not_to be_empty
    expect(page.all('p.body-answer').count).to eq(4)    
  end
  
end