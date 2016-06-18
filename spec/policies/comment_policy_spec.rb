require 'rails_helper'

describe CommentPolicy do
  subject { CommentPolicy.new(user, comment) }

  context 'with user' do
    let(:user)     { create(:user) }
    let(:comment) { create(:comment) }

    context 'comments' do
      let(:comments) { create_list(:comment, 3) }
      it { should permit_action(:index) }
    end

    context 'his comment' do
      let(:comment) { create(:comment, user: user) }
      it { should permit_action :show }
      it { should permit_action :new }
      it { should permit_action :create }
      it { should permit_action :update }
      it { should permit_action :edit }
      it { should permit_action :destroy }
    end

    context 'foreign comment' do
      let(:comment) { create(:comment) }
      it { should forbid_action :update }
      it { should forbid_action :edit }
      it { should forbid_action :destroy }
    end
  end

  context 'with admin' do
    let(:user)     { create(:user, admin: true) }
    let(:comment) { create(:comment) }

    context 'comments' do
      let(:comment) { create_list(:comment, 3) }
      it { should permit_action(:index) }
    end

    it { should permit_action :show }
    it { should permit_action :new }
    it { should permit_action :create }
    it { should permit_action :update }
    it { should permit_action :edit }
    it { should permit_action :destroy }
  end

  context 'with guest' do
    let(:user) { nil }
    let(:comment) { create(:comment) }

    context 'comments' do
      let(:comments) { create_lost(:comment, 3) }
      it { should permit_action(:index) }
    end

    it { should permit_action :show }
    it { should forbid_action :new }
    it { should forbid_action :create }
    it { should forbid_action :destroy }
    it { should forbid_action :update }
  end
end
