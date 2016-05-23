class Vote < ActiveRecord::Base
  belongs_to :votable, polymorphic: true 
  belongs_to :user

  include VoteHelper

  validates :user_id, :vote_type, presence: true
  validates_with VoteValidator

  enum vote_type: [:down, :up]
  
  after_create  :process_votable_rang

  private

  def process_votable_rang
    votable_votes = Vote.where(votable: self.votable, user: user)
    rang = consider_rang(votable_votes)
    if votable_votes.count == 2
      rang = user_rating(votable_votes)
      self.votable.votes.where(user: user).destroy_all
    end
    self.votable.update_attribute(:rang, rang)
  end

  def consider_rang(votable_votes)
    positive = self.votable.votes.where(vote_type: 1).count
    negative = self.votable.votes.where(vote_type: 0).count
    positive - negative
  end

  def user_rating(votable_votes)
    type = votable_votes.map(&:vote_type)
    if type.first == type.second
      vote = Vote.vote_types[type.first] 
      vote == 0 ? -1 : 1
    else
      0
    end
  end
end
