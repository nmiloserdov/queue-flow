FactoryGirl.define do
  factory :up_vote, class: "Vote" do
    vote_type :up 
    user
    votable nil
  end

  factory :down_vote, class: "Vote" do
    vote_type :down
    user
    votable nil
  end
end
