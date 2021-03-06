class AnswersController < ApplicationController
  include Voted

  before_action :authenticate_user!, only: [:create, :destroy]
  before_action :load_answer, only: [:destroy, :update] 

  def create
    authorize Answer
    @question = Question.find(params[:question_id])
    @answer = @question.answers.new(answer_params.merge(user: current_user))
    @comment = Comment.new
    if @answer.save
      flash[:notice] = "Answer successfully added."
    else
      flash[:alert] = "Answer not created."
    end
  end

  def destroy
    authorize @answer
    if current_user.author_of?(@answer) && @answer.destroy
      flash[:notice] = "Your answer is deleted."
    else
      flash[:notice] = "You cant delete not your answer"
    end
  end
  
  def update
    authorize @answer
    if @answer.update(answer_params)
      @question = @answer.question
      flash[:notice] = "Your answer updated"
    else
      flash[:alert]  = "Your answer not-updated"
    end
  end
  
  def best
    authorize @answer
    @answer = Answer.find(params[:answer_id])
    if current_user.author_of?(@answer.question)
      @answer.make_best
    else
      render status: 403
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:body, attachments_attributes: [:id,:file, :_destroy])
  end

  def load_answer
    @answer = Answer.find(params[:id])
  end
  
end
