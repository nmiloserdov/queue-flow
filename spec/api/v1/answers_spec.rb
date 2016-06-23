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
        expect(response.body).to have_json_size(1)
      end

      %w(id body created_at updated_at).each do |attr|
        it "question object contains #{attr}" do
          expect(response.body).to be_json_eql(answer.send(attr.to_sym).to_json)
            .at_path("answer/#{attr}")
        end
      end

    end
  end
end
