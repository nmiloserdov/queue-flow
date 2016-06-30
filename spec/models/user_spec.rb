require 'rails_helper'

RSpec.describe User, type: :model do

  it { should have_many(:answers).dependent(:destroy) }
  it { should have_many(:questions).dependent(:destroy) }
  it { should have_many(:votes) }
  it { should have_many(:subscription) }

  it { should validate_presence_of :email }
  it { should validate_presence_of :password}

  describe '.find_for_oauth' do

    let!(:user) { create(:user) }

    context 'user has not authorization' do
      context 'authenticate with facebook' do
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

      context 'authenticate with twitter' do
        context 'user is registered' do

          let(:auth) { OmniAuth::AuthHash.new(provider: 'twitter', uid: '123456', email: user.email) }

          it 'returns user'do
            expect(User.find_for_oauth(auth)).to be_a(User)
          end

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

          it 'does not create authorization if it exists' do
            user = User.find_for_oauth(auth)
            user = User.find_for_oauth(auth)
            expect(user.authorizations.size).to eq(1)
          end
        end
      end

      context 'then user not registred' do
        let(:auth) { OmniAuth::AuthHash.new(provider: 'twitter', uid: '123456') }

        it 'not creates user' do
          expect { User.find_for_oauth(auth) }.not_to change(User, :count)
        end

        it 'returns user object with confirmation token' do
          user = User.find_for_oauth(auth)
          expect(user).to be_a(User)
          expect(user.email).to be_empty
          expect(user.confirmation_token).not_to be_empty
        end

        it 'returns authentication with user' do
          user = User.find_for_oauth(auth)
          expect(user).to be_a(User)
          expect(user.authorizations).not_to be_empty
          expect(user.authorizations.first).to be_a(Authorization)
        end
      end
    end
  end

  describe '#confirm!' do
    let!(:user) { create(:user, confirmation_token: "123123",
      unconfirmed_email: "hello@mail.ru") }
    let!(:auth) { create(:authorization, user: user) }
    it "updates attributes" do
      user.confirm!
      expect(user.email).to eq("hello@mail.ru")
      expect(user.confirmation_token).to eq(nil)
      expect(user.unconfirmed_email).to eq(nil)
    end
  end
end
