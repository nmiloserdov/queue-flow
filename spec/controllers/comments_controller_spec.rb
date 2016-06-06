require 'rails_helper'

RSpec.describe CommentsController, type: :controller do

  let!(:user)    { create(:user) }
  let(:answer)   { create(:answer) }
  let!(:question) { create(:question) }
  let(:comment)  { create(:comment, user: user, commentable: question) }

  describe "#create" do
    context 'when user sign in' do

      sign_in_user

      it "assigns question to @commentable" do
        post :create, question_id: question, comment: attributes_for(:comment), format: :js
        expect(assigns(:commentable)).to eq(question)
      end

      it "assigns answer to @commentable" do
        post :create, answer_id: answer, comment: attributes_for(:comment), format: :js
        expect(assigns(:commentable)).to eq(answer)
      end

      context "when success" do
        it "renders json" do
          post :create, question_id: question, comment: attributes_for(:comment), format: :js
          expect(response.body).to be_blank
        end
        
        it "creates comment" do
          expect { post :create, question_id: question, comment: attributes_for(:comment), format: :js }
            .to change{ Comment.count }.by(1)
        end

        it "publishes" do
          expect(PrivatePub).to receive(:publish_to)
          post :create, question_id: question, comment: attributes_for(:comment), format: :js
        end
      end

      context "when error" do
        it "renders js" do
          post :create, question_id: question, comment: attributes_for(:comment, body: ""), format: :js
          expect(response).to render_template(:create)
        end
        it "not publishes" do
          expect(PrivatePub).not_to receive(:publish_to)
          post :create, question_id: question, comment: attributes_for(:comment, body: ""), format: :js
        end
      end
    end
  end

  describe "#destroy" do
    context "when user sign in" do
      sign_in_user

      it "assings comment to @comment" do
        delete :destroy, id: comment, format: :js
        expect(assigns(:comment)).to eq(comment)
      end

      it "assigns question to @question" do
        delete :destroy, id: comment, format: :js
        expect(assigns(:question)).to eq(question)
      end

      before do
       @owner_comment = create(:comment, user: @user, commentable: question)
      end

      it "deletes" do
        expect { delete :destroy, id: @owner_comment, format: :js }
          .to change(Comment, :count).by(-1)
      end
    end
  end
end
