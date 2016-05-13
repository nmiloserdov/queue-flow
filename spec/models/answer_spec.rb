require 'rails_helper'

RSpec.describe Answer, type: :model do
  
  let(:question) { create(:question) }
  let(:answer) { create(:answer, question: question) }
  let(:another_answer) { create(:answer, question: question) }

  it { should belong_to :question }
  it { should belong_to :user }
  it { should have_db_index :question_id}
  it { should have_db_index :user_id}

  it { should have_many :attachments }
  it { should accept_nested_attributes_for :attachments }

  it { should validate_presence_of :body }
  it { should validate_presence_of :question_id}
  it { should validate_presence_of :user_id}  
  
  it "make answer best" do
    answer.update(best: true)
    another_answer.save
    expect{ another_answer.make_best }.to change{ answer.reload.best }.to(false)
  end

  it "cancel a best answer when the new best answer for question is selected" do
    answer.make_best
    another_answer.make_best
    expect(question.best_answer).to eq(another_answer) 
  end
end
