class AnswersController < ApplicationController
  
  def create
    question = Question.find(params[:question_id])
    @answer = question.answers.new(answer_params)
    if @answer.save 
      redirect_to question_path(@answer.question)
    else
      # alert message
      redirect_to question_path(@answer.question)
    end
  end
  
  def destroy
    @answer = Answer.find(params[:id])
    if @answer.destroy
      redirect_to @answer.question
    else
      # render error
    end
  end
  
  private

  def answer_params
    params.require(:answer).permit(:body)
  end
  
end
