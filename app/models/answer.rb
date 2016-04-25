class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :user
  has_many   :attachments

  accepts_nested_attributes_for :attachments

  validates :body, :user_id, :question_id, presence: true

  default_scope -> { order(best: :desc, created_at: :desc) }

  def make_best
    ActiveRecord::Base.transaction do
      if self.question.best_answer.nil?
        self.update!(best: true)
      else
        self.question.best_answer.update!(best: false)
        self.update!(best: true)
      end
    end
  end
end
