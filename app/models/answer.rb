class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :user
    
  validates :body, :user_id, :question_id, presence: true
end
