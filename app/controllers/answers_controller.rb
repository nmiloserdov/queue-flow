class AnswersController < ApplicationController
  
  before_action :authenticate_user!, only: [:create, :destroy]
  

  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.new(answer_params)
    if @answer.save 
      current_user.answers.push(@answer)
      flash[:notice] = "Answer successfully added."      
      redirect_to @answer.question
    else
      # alert message
      render "questions/show"
    end
  end
  
  def destroy

    @answer = Answer.find(params[:id])
    if current_user.answers.include?(@answer)
      @answer.destroy
      flash[:notice] = "Your answer is deleted."
      redirect_to @answer.question
    else
      flash[:notice] = "You cant delete your answer"
      redirect_to @answer.question
    end
  end
  
  private

  def answer_params
    params.require(:answer).permit(:body)
  end
  
end
