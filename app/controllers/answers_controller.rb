class AnswersController < ApplicationController
  
  def create
    @answer = Answer.create(answer_params)
    if @answer.save 
      redirect_to @answer.question
    else
      render @answer.question
    end
  end
  
  private
  
    def answer_params
      params.require(:answer).permit(:title,:question_id)
    end
  
end
