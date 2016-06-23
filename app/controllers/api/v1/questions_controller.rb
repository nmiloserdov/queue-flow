class Api::V1::QuestionsController < Api::V1::BaseController

  def index
    @questions = Question.all
    respond_with(@questions)
  end

  def show
    load_question
    respond_with(@question)
  end

  private
  
  def load_question
    @question = Question.find(params[:id])
  end
end
