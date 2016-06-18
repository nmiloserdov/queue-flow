require 'rails_helper'

describe QuestionPolicy do
  subject { QuestionPolicy.new(user, question) }

  context 'with user' do
    let(:user)     { create(:user) }
    let(:question) { create(:question) }

    context 'questions' do
      let(:questions) { create_list(:question, 3) }
      it { should permit_action(:index) }
    end

    context 'his question' do
      let(:question) { create(:question, user: user) }
      it { should permit_action :show }
      it { should permit_action :new }
      it { should permit_action :create }
      it { should permit_action :update }
      it { should permit_action :edit }
      it { should permit_action :destroy }

      it { should forbid_action :upvote }
      it { should forbid_action :downvote }
    end

    context 'foreign question' do
      let(:question) { create(:question) }
      it { should forbid_action :update }
      it { should forbid_action :edit }
      it { should forbid_action :destroy }

      it { should permit_action :upvote }
      it { should permit_action :downvote }
    end
  end

  context 'with admin' do
    let(:user)     { create(:user, admin: true) }
    let(:question) { create(:question) }

    context 'questions' do
      let(:questions) { create_list(:question, 3) }
      it { should permit_action(:index) }
    end

    it { should permit_action :show }
    it { should permit_action :new }
    it { should permit_action :create }
    it { should permit_action :update }
    it { should permit_action :edit }
    it { should permit_action :destroy }

    it { should permit_action :upvote }
    it { should permit_action :downvote }
  end

  context 'with guest' do
    let(:user) { nil }
    let(:question) { create(:question) }

    context 'questions' do
      let(:questions) { create_lost(:question, 3) }
      it { should permit_action(:index) }
    end

    it { should permit_action :show }
    it { should forbid_action :new }
    it { should forbid_action :create }
    it { should forbid_action :destroy }
    it { should forbid_action :update }

    it { should forbid_action :upvote }
    it { should forbid_action :downvote }
  end
end
