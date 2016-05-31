class Vote < ActiveRecord::Base
  belongs_to :votable, polymorphic: true 
  belongs_to :user

  include VoteHelper

  validates :user_id, :vote_type, presence: true
  validates_with VoteValidator

  enum vote_type: { down: -1, up: 1 }
  
  after_create  :process_rang

  private

  def process_rang
    votes = Vote.where(votable: self.votable, user: user)
    if votes.count >= 2
      if votes.map(&:vote_type).inject { |f,l| f==l  }
        votes.last.destroy
      else
        votes.destroy_all
      end
    end
    rang = self.votable.votes.sum(:vote_type)
    self.votable.update_attribute(:rang, rang)
  end
end
