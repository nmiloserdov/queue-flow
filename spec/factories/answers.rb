FactoryGirl.define do

  factory :answer do
    body "test answer"
    question
    user
  end

  factory :invalid_answer, class: "Answer" do
    body nil
    question
  end

end
