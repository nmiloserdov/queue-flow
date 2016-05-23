class Question < ActiveRecord::Base

  belongs_to :user 
  has_many   :answers, dependent: :destroy
  has_many   :attachments, as: :attachmentable, dependent: :destroy
  has_many   :votes, as: :votable

  accepts_nested_attributes_for :attachments, reject_if: :all_blank

  validates  :title, :body, :user_id, presence: true

  def best_answer
    self.answers.find_by(best: true)
  end

  private

  def process_rang
    votes = self.votes
    positive = votes.where(vote_type: :up).count
    negative = votes.where(vote_typw: :down).count
    self.rang = positive - negative
  end
end
