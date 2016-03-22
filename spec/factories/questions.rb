FactoryGirl.define do
  sequence :body do |n| 
    "title number #{n}"
  end
  
  factory :question do
    title "test"
    body     
    user
  end
  
  factory :invalid_question, class:  "Question" do
    title nil
    body  nil
  end
end
