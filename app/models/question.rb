class Question < ActiveRecord::Base

  belongs_to :user 

  has_many :answers, dependent: :destroy
  has_many :attachments, as: :attachmentable, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :votes, as: :votable
  has_many :subscriptions, dependent: :destroy

  accepts_nested_attributes_for :attachments, reject_if: :all_blank

  validates  :title, :body, :user_id, presence: true

  scope :daily_delivery, -> { where("created_at >= ?", 1.day.ago) }

  after_create :subscribe_owner_to_question

  def best_answer
    self.answers.find_by(best: true)
  end

  private

  def subscribe_owner_to_question
    self.user.subscribe_to!(self)
  end
end
