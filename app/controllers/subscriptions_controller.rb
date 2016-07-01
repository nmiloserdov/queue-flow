class SubscriptionsController < ApplicationController

  before_action :authenticate_user!

  def create
    load_question
    authorize @question, :subscribe?
    if current_user.subscribe_to!(@question)
      render json: { subscription: true } 
    end
  end

  def destroy
    load_question
    authorize @question, :unsubscribe?
    if current_user.unsubscribe_from!(@question)
      render json: { subscription: false }
    end
  end

  private

  def load_question
    @question = Question.find(params[:question_id])
  end
end
