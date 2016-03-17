class AnswersController < ApplicationController
  
  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.new(answer_params)
    if @answer.save 
      redirect_to @answer.question
    else
      # alert message
      render "questions/show"
    end
  end
  
  def destroy
    @answer = Answer.find(params[:id]).destroy
    redirect_to @answer.question
    # render messages
  end
  
  private

  def answer_params
    params.require(:answer).permit(:body)
  end
  
end
