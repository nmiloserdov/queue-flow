require 'rails_helper'

describe AnswerPolicy do
  subject { AnswerPolicy.new(user, answer) }

  context 'with user' do
    let(:user)     { create(:user) }
    let(:answer) { create(:answer) }

    context 'answers' do
      let(:answers) { create_list(:answers, 3) }
      it { should permit_action(:index) }
    end

    context 'his answer' do
      let(:answer) { create(:answer, user: user) }
      it { should permit_action :show }
      it { should permit_action :new }
      it { should permit_action :create }
      it { should permit_action :update }
      it { should permit_action :edit }
      it { should permit_action :destroy }

      it { should forbid_action :upvote }
      it { should forbid_action :downvote }
    end

    context 'foreign answer' do
      let(:answer) { create(:answer) }
      it { should forbid_action :update }
      it { should forbid_action :edit }
      it { should forbid_action :destroy }

      it { should permit_action :upvote }
      it { should permit_action :downvote }
    end
  end

  context 'with admin' do
    let(:user)   { create(:user, admin: true) }
    let(:answer) { create(:answer) }

    context 'answers' do
      let(:answers) { create_list(:answer, 3) }
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
    let(:answer) { create(:answer) }

    context 'answers' do
      let(:answers) { create_lost(:answers, 3) }
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
