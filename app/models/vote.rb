class Vote < ActiveRecord::Base
  belongs_to :votable, polymorphic: true 
  belongs_to :user

  include VoteHelper

  validates :user_id, :vote_type, presence: true
  validates_with VoteValidator

  enum vote_type: [:down, :up]
  
  after_create  :process_rang

  private

  def process_rang
    votable_votes = Vote.where(votable: self.votable, user: user)
    rang = consider_rang + vote_type_to_i
    if votable_votes.count >= 2
      rang = user_votes(votable_votes) + consider_rang
    end
    self.votable.update_attribute(:rang, rang)
  end

  # logic for non-repeat user votes
  def user_votes(votable_votes)
    type = votable_votes.map(&:vote_type)
    if type.first == type.second
      vote = Vote.vote_types[type.first] 
      self.votable.votes.where(user: user).last.destroy
      vote == 0 ? -1 : 1
    else
      self.votable.votes.where(user: user).destroy_all
      return 0
    end
  end

  # consider rang without user votes
  def consider_rang
    votes = self.votable.votes.where.not(user: self.user)
    positive = votes.where(vote_type: 1).count
    negative = votes.where(vote_type: 0).count
    positive - negative
  end

  def vote_type_to_i
    vote = Vote.vote_types[self.vote_type]
    vote == 0 ? -1 : 1
  end
end
