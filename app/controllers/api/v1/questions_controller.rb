class Api::V1::QuestionsController < Api::V1::BaseController

  # respond_with(@somenthing), serializer: 'SerClassName'

  def index
    authorize :api
    @questions = Question.all
    respond_with(@questions)
  end

  def show
    load_question
    authorize :api
    respond_with(@question)
  end

  def create
    authorize :api
    respond_with(@question = current_resource_owner.questions.create(question_params))
  end

  private
  
  def load_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body)
  end
end
