require 'rails_helper'

RSpec.describe AnswersController, type: :controller do

  let(:question) { create(:question) }
  let(:answer) { create(:answer) }
  
 
  describe 'POST #create' do
    sign_in_user
    context 'with valid params' do

      it 'save answer to the database' do
        expect {  post :create, question_id: question, 
                                answer: attributes_for(:answer),
                                format: :js }
            .to change(question.answers, :count).by(1)
      end
     
      it 'assigns answer to @user.answer' do
        expect { post :create, question_id: question, 
              answer: attributes_for(:answer), format: :js }.to change(@user.answers, :count).by(1)
      end
    end
    
    context 'with invalid params' do
      
      let(:invalid_answer) { create(:invalid_answer) }
      
      it 'dont save question in database' do
        expect { post :create, question_id: question, 
                      answer: attributes_for(:invalid_answer),
                      format: :js }
            .to_not change(Answer, :count)
      end
    end
    
  end

  describe 'PATCH #update' do
    sign_in_user    
    
    context 'valid attributes' do
      it 'assigns the requested answer to @answer' do
        patch :update, id: answer, question_id: question, answer: attributes_for(:answer), format: :js
        expect(assigns(:answer)).to eq(answer)
      end
      
      it 'change question attributes' do
        patch :update, id: answer, question_id: question, answer: { body: "updated_body"}, format: :js
        answer.reload
        expect(answer.body).to eq 'updated_body'
      end
      
      it 'render update template' do
       patch :update, id: answer, question_id: question, answer: attributes_for(:answer), format: :js
       expect(response).to render_template :update
     end 
    end
    
    context 'invalid attributes' do
      let(:old_answer) { create(:answer) }
      it "dont't change answer attributes" do
        patch :update, id: answer ,question_id: question, answer: { body: nil }, format: :js
        answer.reload
        expect(answer.body).to eq old_answer.body
      end
    
    end

  end
  
  describe 'DELETE #destroy' do  
    sign_in_user

    it 'not delete if you are not owner of answer' do 
      expect { delete :destroy, question_id: question, id: answer}
                      .to change(@user.answers, :count).by(0)
    end

    it 'delete answer' do
      @user.answers << (answer)
      expect { delete :destroy, question_id: question, id: answer}
                      .to change(@user.answers, :count).by(-1)
    end

    it 'redirect_to question answer' do
      delete :destroy, question_id: question, id: answer 
      expect(response).to redirect_to answer.question
    end
  end
    
end
