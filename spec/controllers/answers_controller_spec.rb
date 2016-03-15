require 'rails_helper'

RSpec.describe AnswersController, type: :controller do

  let(:question) { create(:question) }

  describe 'POST #create' do

    context 'with valid params' do

      it 'save answer to the database' do
        expect { post :create, answer: attributes_for(:answer, question_id: question) }
                      .to change(Answer, :count).by(1)
      end
      
      it 'redirect_to question' do
        post :create, answer: attributes_for(:answer, question_id: question) 
        expect(response).to redirect_to question
      end
    end
    
    context 'with invalid params' do
      
      let(:invalid_answer) { create(:invalid_answer) }
      
      it 'dont save question in database' do
        expect { post :create, answer: attributes_for(:invalid_answer,
                                                      question_id: question) }
            .to_not change(Answer, :count)
      end
      
      it 'render question' do
        post :create, answer: attributes_for(:invalid_answer, 
                                              question_id: question)
        expect(response).to redirect_to question
      end
    end
    
  end
  
  
end
