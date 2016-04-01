class AnswersController < ApplicationController
  
  before_action :authenticate_user!, only: [:create, :destroy]
  before_action :load_answer, only: [:destroy, :update] 

  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.new(answer_params.merge(user: current_user))
    if @answer.save 
      flash[:notice] = "Answer successfully added."      
    else
      flash[:alert] = "Answer not created."
    end
  end
  
  def destroy
    if current_user.author_of?(@answer) && @answer.destroy
      flash[:notice] = "Your answer is deleted."
    else
      flash[:notice] = "You cant delete not your answer"
    end
    redirect_to @answer.question
  end
  
  def update
    @question = @answer.question
    if @answer.update(answer_params)
      flash[:notice] = "Your answer updated"
    else
      flash[:alert]  = "Your answer not-updated"
    end
  end
  
  private

  def answer_params
    params.require(:answer).permit(:body)
  end

  def load_answer
    @answer = Answer.find(params[:id])
  end
  
end
