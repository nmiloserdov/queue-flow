FactoryGirl.define do
  factory :comment do
    body "nice comment"
    user 
    commentable { create(:answer) }
  end
end
