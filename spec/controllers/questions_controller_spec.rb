require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
 
  let(:question) { create(:question) }

  describe 'GET #index' do
    before { get :index }
    
    let(:questions) { create_list(:question, 2) }

    context 'when user not log in' do

      it 'populates an array of all questions' do
        expect(assigns(:questions)).to match_array(questions)
      end
       
      it "not assing user to @user" do
        expect(assigns(:user)).to be_nil
      end
          
      it 'renrers index view' do
        expect(response).to render_template :index
      end      
    end

  end
  
  describe 'GET #show' do
    before { get :show, id: question }
    
    it "assigns the request question to @question" do   
      expect(assigns(:question)).to eq(question)
    end
    
    it "assigns the answers of question to @answers" do
      question.answers = ( create_list(:answer, 2) )
      expect(assigns(:answers).count).to eq(question.answers.count)
    end
      
    it "renders show view" do
      expect(response).to render_template :show
    end
  end
  
  describe 'GET #new' do
    sign_in_user
    
    before { get :new }
    
    it 'assigns a new Question to @question' do
      expect(assigns(:question)).to be_a_new(Question)
    end
   
    it 'assigns a new attachment to @question.attachments' do
      expect(assigns(:question).attachments.first).to be_a_new(Attachment)
    end
    it 'renders new view' do
      expect(response).to render_template :new
    end
  end
  
  describe 'GET #edit' do
    sign_in_user
    
    before{ get :edit, id: question } 
  
    it 'assigns the requested question to @question' do
      expect(assigns(:question)).to eq(question)
    end
    
    it 'renders edit view' do
      expect(response).to render_template :edit
    end
  end
  
  describe 'POST #create' do
    sign_in_user    
    
    context "with valid attributes" do
     
      it 'assign question to @user.questions' do
        expect { post :create, question: attributes_for(:question) } 
        .to change(@user.questions,:count).by(1)
      end

      it "redirect to question" do
        post :create, question: attributes_for(:question)
        expect(response).to redirect_to question_path(assigns(:question))
      end
    end
    
    context "with invalid attributes" do

      it "dosen't save the question" do
        expect { post :create, question: 
                          attributes_for(:invalid_question) }
                  .to_not change(Question, :count)
      end
      
      it "re-render new view" do
        post :create, question: attributes_for(:invalid_question) 
        expect(response).to render_template :new
      end
    end 
  end
  
  describe 'PATCH #update' do
    sign_in_user    
    
    context 'valid attributes' do
      it 'assigns the requested question to @question' do
        patch :update, id: question, question: attributes_for(:question), format: :js
        expect(assigns(:question)).to eq(question)
      end
      
      it 'change question attributes' do
        patch :update, id: question, question: { title: "title", body: "body"}, format: :js
        question.reload
        expect(question.title).to eq 'title'
        expect(question.body).to eq 'body'
      end
    end
    
    context 'invalid attributes' do
      let(:old_question) { question }
      before { patch :update, id: question, question: { title: 'title', body: nil}, format: :js} 
     it "dont't change question attributes" do
        question.reload
        expect(question.title).to eq old_question.title
        expect(question.body).to eq old_question.body
      end
    end
  end
  
  describe 'DELETE #destroy' do
    sign_in_user          

    it 'user delete his question' do
      @user.questions << question
      expect { delete :destroy, id: question }
                            .to change(@user.questions, :count).by(-1) 
    end
  
    it 'user delete not his question' do
      expect { delete :destroy, id: question }
                            .to change(question.user.questions, :count).by(0)   
    end  

    it 'redirect to view' do
      delete :destroy, id: question
      expect(response).to redirect_to questions_path
    end
  
  end
end
