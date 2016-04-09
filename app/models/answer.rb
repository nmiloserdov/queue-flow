class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :user
    
  validates :body, :user_id, :question_id, presence: true

  def make_best
    if self.question.answers.find_by(best: 1).nil?
      self.update_attribute(:best, 1)
    else
      self.question.best_answer.update_attribute(:best, 0)
      self.update_attribute(:best, 1)
    end
  end
  
end
