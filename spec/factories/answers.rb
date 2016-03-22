FactoryGirl.define do

  factory :answer do
    body "test"
    question
    user
  end

  factory :invalid_answer, class: "Answer" do
    body nil
    question
  end

end
