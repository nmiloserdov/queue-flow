class Api::V1::AnswersController < Api::V1::BaseController

  def index
    load_question
    authorize :api
    respond_with(@question.answers)
  end

  def show
    load_answer
    authorize :api
    respond_with(@answer)
  end

  def create
    load_question
    authorize :api
    respond_with(@question.answers.create(answer_params
      .merge(user_id: current_resource_owner.id)))
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end

  def load_answer
    @answer = Answer.find(params[:id])
  end

  def load_question
    @question = Question.find(params[:question_id])
  end
end
