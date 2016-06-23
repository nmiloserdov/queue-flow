require 'rails_helper'

describe 'Answers API' do

  describe 'GET /index' do
    context 'unauthorized' do

      it 'returns 401 status if there is no access_token' do
        get "/api/v1/questions/1/answers/1", format: :json
        expect(response.status).to eq 401
      end

      it 'returns 401 status if access_token is invalid' do
        get "/api/v1/questions/1/answers/1", format: :json, access_token: '1234'
        expect(response.status).to eq 401
      end
    end

    context 'authorized' do
      let(:access_token) { create(:access_token) }
      let(:question)     { create(:question) }
      let!(:answers)     { create_list(:answer, 2, question: question) }
      let(:answer)       { answers.first }

      before do
        get "/api/v1/questions/#{question.id}/answers", format: :json, access_token: access_token.token
      end

      it 'returns 200 status code' do
        expect(response).to be_success
      end

      it 'returns list of questions' do
        expect(response.body).to have_json_size(2)
      end

      %w(id body created_at updated_at).each do |attr|
        it "question object contains #{attr}" do
          expect(response.body).to be_json_eql(answer.send(attr.to_sym).to_json)
            .at_path("1/#{attr}")
        end
      end
    end
  end


  describe '#GET /show' do

    let(:question)     { create(:question) }
    let!(:answers)     { create_list(:answer, 2, question: question) }
    let(:answer)       { answers.first }
    let!(:comments)    { create_list(:comment,    2, commentable: answer) }
    let!(:attachments) { create_list(:attachment, 2, attachmentable: answer) }

    context 'unauthorized' do

      it 'returns 401 status if there is no access_token' do
        get "/api/v1/questions/#{question.id}/answers/#{answer.id}/", format: :json
        expect(response.status).to eq 401
      end

      it 'returns 401 status if access_token is invalid' do
        get "/api/v1/questions/#{question.id}/answers/#{answer.id}", format: :json, access_token: '1234'
        expect(response.status).to eq 401
      end
    end

    context 'authorized' do
      let(:access_token) { create(:access_token) }

      before do
        get "/api/v1/questions/#{question.id}/answers/#{answer.id}/", format: :json, access_token: access_token.token
      end

      it 'returns 200 status code' do
        expect(response).to be_success
      end

      it 'returns answer' do
        expect(response.body).to have_json_size(8)
      end

      %w(id body created_at updated_at).each do |attr|
        it "question object contains #{attr}" do
          expect(response.body).to be_json_eql(answer.send(attr.to_sym).to_json)
            .at_path("#{attr}")
        end
      end

      describe 'comments' do
        it 'contains comments' do
          expect(response.body).to have_json_size(2).at_path('comments')
        end

        %w(id body created_at updated_at).each do |attr|
          it "comment object contains #{attr}" do
            expect(response.body).to be_json_eql(comments.first.send(attr.to_sym).to_json)
              .at_path("comments/0/#{attr}")
          end
        end
      end

      describe 'attachments' do
        it 'contains attachments' do
          expect(response.body).to have_json_size(2).at_path('attachments')
        end

        it "attachment object contains url" do
          expect(response.body).to be_json_eql(attachments.first.file.url.to_json)
            .at_path("attachments/0/url")
        end
      end
    end
  end

  describe 'POST /answers' do
    let!(:question)    { create(:question) }

    context 'unauthorized' do

      it 'returns 401 status if there is no access_token' do
        post "/api/v1/questions/#{question.id}/answers", format: :json
        expect(response.status).to eq 401
      end

      it 'returns 401 status if access_token is invalid' do
        get "/api/v1/questions/#{question.id}/answers", format: :json, access_token: '1234'
        expect(response.status).to eq 401
      end
    end

    context 'authorized' do
      let(:user)         { create(:user) }
      let(:access_token) { create(:access_token,resource_owner_id: user.id) }

      context 'good params' do
        let(:answer) { attributes_for(:answer) }

        it 'returns 200 status code' do
          post "/api/v1/questions/#{question.id}/answers", format: :json, access_token: access_token.token, answer: answer
          expect(response).to be_success
        end

        it 'creates answer' do
          expect { post "/api/v1/questions/#{question.id}/answers", format: :json,
             access_token: access_token.token, answer: answer
          }.to change(question.answers, :count).by(1)
        end
      end

      context 'bad params' do
        let(:answer) { attributes_for(:answer, body: nil) }

        it 'returns 422 status code' do
          post "/api/v1/questions/#{question.id}/answers", format: :json,
            access_token: access_token.token, answer: answer
          expect(response.status).to eq 422 
        end

        it 'not creates answer' do
          expect { post "/api/v1/questions/#{question.id}/answers", format: :json,
            access_token: access_token.token, answer: answer
          }.not_to change(question.answers, :count)
        end
      end
    end
  end
end
