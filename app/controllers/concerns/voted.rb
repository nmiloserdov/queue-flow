module Voted
  extend ActiveSupport::Concern

  def vote
    @vote = build_vote
    if @vote.save
      render json: { rang: @vote.votable.rang,
        votable: votable_name, id: @vote.votable.id }
    else
      render json: { errors: @vote.errors.full_messages,
        votable: votable_name, id: @vote.votable.id }
    end
  end

  private

  def votable_name
    controller_name.classify.downcase
  end

  def vote_object
    id = params[:id] || params[:question_id] || params[:answer_id]
    @votable = controller_name.classify.constantize.find(id)
  end

  def build_vote
    Vote.new(user: current_user, vote_type: params[:type],
      votable: vote_object)
  end
end
