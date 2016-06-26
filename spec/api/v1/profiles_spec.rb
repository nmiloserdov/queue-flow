require 'rails_helper'

describe 'Profile API' do

  let(:me)           { create(:user) }
  let(:access_token) { create(:access_token, resource_owner_id: me.id) }

  describe 'GET /me' do

    it_behaves_like 'API authenticable'

    context 'authorizated' do

      before { get '/api/v1/profiles/me', format: :json, access_token: access_token.token }

      it 'returns 200 status' do
        expect(response).to be_success
      end

      %w(id email created_at updated_at admin).each do |attr|
        it "contains #{attr}" do
          expect(response.body).to be_json_eql(me.send(attr.to_sym).to_json)
            .at_path(attr)
        end
      end

      %w(password password_confirmation).each do |attr|
        it "dosent contains #{attr}" do
          expect(response.body).not_to have_json_path(attr)
        end
      end
    end
  end

  describe '#GET /index' do

    let(:url) { "/api/v1/profiles" }
    it_behaves_like 'API authenticable'

    context 'authorized' do

      let!(:me)    { create(:user) } 
      let!(:users) { create_list(:user, 2) }

      before do
        get '/api/v1/profiles', format: :json,
          access_token: access_token.token 
      end

      it 'returns 200 status' do
        expect(response).to be_success
      end

      it "dosent contain user profile" do
        expect(response.body).not_to include_json(me.to_json)
      end
      
      it "contain users profile" do
        expect(response.body).to be_json_eql(users.to_json).at_path("users")
      end
    end
  end

  def do_request(options={})
    url = options[:url].nil? ? '/api/v1/profiles/me' : options.delete(:url)
    get url, { format: :json }.merge(options)
  end
end
