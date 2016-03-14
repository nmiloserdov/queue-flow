FactoryGirl.define do

  factory :answer do
    body "test"
    question
  end

  factory :invalid_answer, class: "Answer" do
    body "test"
  end

end
