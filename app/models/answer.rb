class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :user
    
  validates :body, :user_id, :question_id, presence: true

  default_scope -> { order(best: :desc, created_at: :desc) }

  def make_best
    ActiveRecord::Base.transaction do
      if self.question.answers.find_by(best: true).nil?
        self.update_attribute(:best, true)
      else
        self.question.best_answer.update_attribute(:best, false)
        self.update_attribute(:best, true)
      end
    end
  end
  
end
