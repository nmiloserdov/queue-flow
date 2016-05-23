module VoteHelper
  class VoteValidator < ActiveModel::Validator
    def validate(record)
      if record.vote_type && record.votable.user_id == record.user_id
        record.errors[:base] << "Вы не можете голосовать за себя"
      end
    end
  end
end
