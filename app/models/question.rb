class Question < ActiveRecord::Base
  belongs_to :user 
  has_many   :answers, dependent: :destroy
  
  validates  :title, :body, :user_id, presence: true

  def best_answer
    self.answers.find_by(best: true)
  end
end
