require 'rails_helper'

RSpec.describe User do

  it { should have_many(:answers).dependent(:destroy) }
  it { should have_many(:questions).dependent(:destroy) }
  it { should have_many(:votes) }
  
  it { should validate_presence_of :email }
  it { should validate_presence_of :password}

  describe '.find_for_oauth' do

    let!(:user) { create(:user) }
    let(:auth) { OmniAuth::AuthHash.new(provider: 'facebook', uid: '123456') }

    context 'user has not authorization' do
      context 'and authenticate with facebook' do
        context 'user already registered' do

          let(:auth) { OmniAuth::AuthHash.new(provider: 'facebook', uid: '123456',
            info: { email: user.email}) }

          it 'does not create new user' do
            expect { User.find_for_oauth(auth) }.to_not change(User, :count)
          end

          it 'creates authorization for user' do
            expect { User.find_for_oauth(auth) }.to change(user.authorizations, :count).by(1)
          end

          it 'creates authorization for user with provider and uid' do
            user = User.find_for_oauth(auth)
            authorization = user.authorizations.first
            expect(authorization.provider).to eq(auth.provider)
            expect(authorization.uid).to eq(auth.uid)
          end
          
          it 'returns the user' do
            expect(User.find_for_oauth(auth)).to eq(user)
          end
        end

        context 'user is not registered' do
          context 'and authenticate with facebook' do

            let(:auth) { OmniAuth::AuthHash.new(provider: 'facebook', uid: '123456',
              info: {email: "nmiloserdov09@gmail.com"}) }

            it "creates user" do
              expect { User.find_for_oauth(auth) }.to change(User, :count).by(1)
              expect(User.find_for_oauth(auth)).to be_a(User)
              user = User.find_for_oauth(auth)
              expect(user.email).to eq(auth.info.email)
            end

            it "creates authorization with provider and uid" do
              user = User.find_for_oauth(auth)
              expect(user.authorizations).to_not be_empty
              authorization = user.authorizations.first
              expect(authorization.provider).to eq(auth.provider)
              expect(authorization.uid).to eq(auth.uid)
            end
          end
        end
      end
    end
  end
end
