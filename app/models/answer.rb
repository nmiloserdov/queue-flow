class Answer < ActiveRecord::Base
  belongs_to :question, touch: true
  belongs_to :user
  has_many   :attachments, as: :attachmentable, dependent: :destroy
  has_many   :comments, as: :commentable, dependent: :destroy
  has_many   :votes, as: :votable

  after_create :send_notification_for_subscribers

  accepts_nested_attributes_for :attachments, reject_if: :all_blank

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

  private

  def send_notification_for_subscribers
    Mailers::SubscribersNotificationWorker.perform_async(self)
  end
end
