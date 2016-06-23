class Api::V1::AnswersController < Api::V1::BaseController

  def index
    load_question
    respond_with(@question.answers)
  end

  def show
    load_answer
    respond_with(answer: @answer)
  end

  private

  def load_answer
    @answer = Answer.find(params[:id])
  end

  def load_question
    @question = Question.find(params[:question_id])
  end
end
