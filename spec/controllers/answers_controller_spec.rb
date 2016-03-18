require 'rails_helper'

RSpec.describe AnswersController, type: :controller do

  let(:question) { create(:question) }
  let(:answer) { create(:answer) }
  
 
  describe 'POST #create' do
    sign_in_user
    context 'with valid params' do

      it 'save answer to the database' do
        expect {  post :create, question_id: question, 
                              answer: attributes_for(:answer) }
            .to change(question.answers, :count).by(1)
      end
      
      it 'redirect_to question' do
        post :create, question_id: question, 
                             answer: attributes_for(:answer)
        expect(response).to redirect_to question
      end
    end
    
    context 'with invalid params' do
      
      let(:invalid_answer) { create(:invalid_answer) }
      
      it 'dont save question in database' do
        expect { post :create, question_id: question, 
                        answer: attributes_for(:invalid_answer) }
            .to_not change(Answer, :count)
      end
      
      it 're-render question' do
        post :create, question_id: question, 
                          answer: attributes_for(:invalid_answer)
        expect(response).to render_template "questions/show", id: question
      end
    end
    
  end
  
  describe 'DELETE #destroy' do  
    sign_in_user
    it 'delete answer' do
      answer
      expect { delete :destroy, question_id: question, id: answer }
                    .to change(Answer, :count).by(-1)
    end
    
    it 'redirect_to question answer' do
      delete :destroy, question_id: question, id: answer 
      expect(response).to redirect_to answer.question
    end
  end
    
end
