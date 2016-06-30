class SubscriptionsController < ApplicationController

  before_action :authenticate_user!

  def create
    load_question
    Subscription.create(user: current_user, question: @question)
    render json: { subscription: true }
  end

  def destroy
    load_question
    Subscription.find_by(user: current_user, question: @question).destroy
    render json: { subscription: false }
  end

  private

  def load_question
    @question = Question.find(params[:question_id])
  end
end
