require 'rails_helper'

RSpec.describe Vote, type: :model do
  it { should belong_to :votable }
  it { should validate_presence_of :user_id }
  it { should validate_presence_of :vote_type }

  let!(:user)         { create(:user) }

  let!(:question) { create(:question) }
  let!(:answer)   { create(:answer) }
  let(:question_of_the_owner) { create(:question, user: user) }
  let(:answer_of_the_owner)   { create(:answer,   user: user) }
  #questions
  let(:up_question_vote)   { create(:up_vote,   user: user, votable: question) }
  let(:down_question_vote) { create(:down_vote, user: user, votable: question) }
  let(:owner_qs_vote)      { create(:up_vote,   user: user, votable: question_of_the_owner) }
  #answers
  let(:up_answer_vote)   { create(:up_vote,   user: user, votable: answer) }
  let(:down_answer_vote) { create(:down_vote, user: user, votable: answer) }
  let(:owner_as_vote)    { create(:up_vote,   user: user, votable: answer_of_the_owner) }

  describe "validate before created" do
    it "not creates vote if user is owner of votable model" do
      expect { owner_qs_vote }.to raise_error(ActiveRecord::RecordInvalid)
      expect { owner_as_vote }.to raise_error(ActiveRecord::RecordInvalid)
    end

    context "not creates if user voting twice" do
      it 'up' do
        2.times {
          create(:up_vote, user: user, votable: question)
          create(:up_vote, user: user, votable: answer)
        }
        expect(question.rang).to eq(1)
        expect(answer.rang).to eq(1)
      end

      it 'down' do
        2.times {
          create(:down_vote, user: user, votable: question)
          create(:down_vote, user: user, votable: answer)
        }
        expect(question.rang).to eq(-1)
        expect(answer.rang).to eq(-1)
      end

      it 'ups and deletes' do
        create(:up_vote,   user: user, votable: question)
        create(:down_vote, user: user, votable: question)
        expect(question.votes.count).to eq 0
        expect(question.rang).to eq 0 
      end

      it 'downs and deletes' do
        create(:down_vote, user: user, votable: question)
        create(:up_vote,   user: user, votable: question)
        expect(question.votes.count).to eq 0
        expect(question.rang).to eq 0 
      end

      it 'ups and downs' do
        create(:up_vote,   user: user, votable: question)
        create(:down_vote, user: user, votable: question)
        create(:down_vote, user: user, votable: question)
        expect(question.votes.count).to eq 1
        expect(question.rang).to eq(-1)
      end

      it 'downs and ups' do
        create(:down_vote,   user: user, votable: question)
        create(:up_vote, user: user, votable: question)
        create(:up_vote, user: user, votable: question)
        expect(question.votes.count).to eq 1
        expect(question.rang).to eq(1)
      end
    end
  end

  describe "update votable model rang" do
    context "question" do
      before  { question.rang = 0 }

      it "down" do
        expect{ down_question_vote }.to change{ question.rang }.from(0).to(-1)
      end

      it "up" do
        expect{ up_question_vote }.to change{ question.rang }.from(0).to(1)
      end
    end

    context "answer" do
      before { answer.rang = 0 }

      it "down" do
        expect{ down_answer_vote }.to change{ answer.rang }.from(0).to(-1)
      end

      it "up" do
        expect{ up_answer_vote }.to change{ answer.rang }.from(0).to(1)
      end
    end
  end

  context "two users" do
    let!(:another_user) { create(:user) }

    it "when to ups" do
      create(:up_vote, user: user, votable: question)
      create(:up_vote, user: another_user, votable: question)
      expect(question.rang).to eq 2
    end

    it "when ups and downs" do
      create(:up_vote, user: user, votable: question)
      create(:down_vote, user: another_user, votable: question)
      expect(question.rang).to eq 0
    end
  end
end
