require 'rails_helper'

RSpec.describe SubscriptionsController, type: :controller do

  shared_examples_for 'non-authenticated user' do
    context 'non-authenticated user' do
      it "dosen't calls method" do
        post action, question_id: question, remote: true
        expect(SubscriptionsController.new).not_to receive(:create)
      end
    end
  end

  describe 'PATCH #create' do

    let(:question) { create(:question) }

    let(:action) { :create }
    it_behaves_like 'non-authenticated user'

    context 'authenticated user' do
      sign_in_user

      it "assigns question to @question" do
        post :create, question_id: question, remote: true
        expect(assigns(:question)).to eq(question)
      end

      it "subsribes user to question" do
        expect { post :create, question_id: question, remote: true }
          .to change(Subscription, :count).by(1)
      end
    end
  end

  describe 'PATCH #destroy' do

    let(:question) { create(:question) }

    let(:action) { :destroy }
    it_behaves_like 'non-authenticated user'

    context 'authenticated user' do
      sign_in_user

      let!(:subs) { create(:subscription, user_id: @user.id, question_id: question.id) }

      it "assigns question to @question" do
        post :destroy, question_id: question, remote: true
        expect(assigns(:question)).to eq(question)
      end

      it "unsubsribes user from question" do
        expect { post :destroy, question_id: question, remote: true }
          .to change(Subscription, :count).by(-1)
      end
    end
    
  end
end
