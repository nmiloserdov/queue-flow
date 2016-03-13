require 'rails_helper'

RSpec.describe Answer, type: :model do
  
  it { should belong_to :question }
  
  it { should validate_presence_of :body }

  answer = Answer.new(body: "i think so")
  
  describe "attributes" do
    
    it "should have right :body" do
      expect(answer).to have_attributes(body: "i think so")
      
    end  
    
    it "should set body" do
      answer.body = "test"
      expect(answer.body).to eq "test"
    end
    
  end
end
