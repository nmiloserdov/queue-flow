class SubscriptionsController < ApplicationController

  before_action :authenticate_user!

  def create
    load_question
    @subs = Subscription.new(user: current_user, question: @question)
    render json: { subscription: true } if @subs.save
  end

  def destroy
    load_question
    @subs = Subscription.find_by(user: current_user, question: @question)
    render json: { subscription: false } if @subs && @subs.destroy
  end

  private

  def load_question
    @question = Question.find(params[:question_id])
  end
end
