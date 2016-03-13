require 'rails_helper'

RSpec.describe Question, type: :model do

  it { should have_many :answers }
  
  it { should validate_presence_of :title }
  it { should validate_presence_of :body }
      
  question = Question.new(title: "Am i new rspec?", body: "Help me, i don't now")

  describe "attributes" do
    it "have right :title" do
      expect(question).to have_attributes(title: "Am i new rspec?")
    end  
    
    it "have right :body" do
      expect(question).to have_attributes(body: "Help me, i don't now")
    end
    
    it "set new :title" do
      question.title = "test"
      expect(question.title).to eq("test")
    end
    
    it "set new :body" do
      question.body = "test"
      expect(question.title).to eq("test")
    end
  end
  
  describe "association" do
    a1 = Answer.new(body: "maybe")
    a2 = Answer.new(body: "no, you don't")
    
    it "have two answers" do
      question.answers.push(u1,u2)
      expect(question.answers).to match_array([a1,a2])
    end
  end
end
