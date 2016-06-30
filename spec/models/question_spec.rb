require 'rails_helper'

RSpec.describe Question, type: :model do
  
  let(:question) { create(:question) }
  let(:answer) { create(:answer, question: question) }
  let(:best_answer) { create(:answer, question: question, best: 1) }

  it { should have_many(:answers).dependent(:destroy) }
  it { should have_many(:comments).dependent(:destroy) }
  it { should belong_to(:user) }
  it { should have_db_index(:user_id) }
  it { should have_many(:attachments) }
  it { should have_many(:votes) }
  it { should have_many(:subscriptions) }
  
  it { should accept_nested_attributes_for :attachments }
  
  it { should validate_presence_of :title }
  it { should validate_presence_of :body }
  it { should validate_presence_of :user_id}    

  it "return best answer from answers" do
    question.answers << answer
    question.answers << best_answer
    expect(question.best_answer).to eq(best_answer)
  end
end
