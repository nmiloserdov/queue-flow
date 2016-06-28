FactoryGirl.define do
  sequence :body do |n| 
    "test  body #{n}"
  end

  factory :question do
    title { generate(:title) }
    body     
    user
  end

  factory :invalid_question, class:  "Question" do
    title nil
    body  nil
  end

  sequence :title do |n|
    "test question title № #{n}"
  end
end
