class AnswersController < ApplicationController
  
  before_action :authenticate_user!, only: [:create, :destroy]
  

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
    @answer = Answer.find(params[:id])
    if current_user.author_of?(@answer) and @answer.destroy
      flash[:notice] = "Your answer is deleted."
    else
      flash[:notice] = "You cant delete not your answer"
    end
    redirect_to @answer.question
  end
  
  private

  def answer_params
    params.require(:answer).permit(:body)
  end
  
end
