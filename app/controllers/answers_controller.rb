class AnswersController < ApplicationController
  include Voted
  
  before_action :authenticate_user!, only: [:create, :destroy]
  before_action :load_answer, only: [:destroy, :update, :best] 
  before_action :load_question, only: [:create]

  respond_to :js, :json

  def create
    @comment = Comment.new
    @answer = @question.answers.create(answer_params.merge(user: current_user))
    respond_with(@answer)
  end
  
  def destroy
    if current_user.author_of?(@answer)
      respond_with(@answer.destroy)
    end
  end
  
  def update
    @question = @answer.question
    respond_with(@answer.update(answer_params))
  end
  
  def best
    if current_user.author_of?(@answer.question)
      respond_with(@answer.make_best)
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:body, attachments_attributes: [:id,:file, :_destroy])
  end

  def load_answer
    id = params[:id] || params[:answer_id]
    @answer = Answer.find(id)
  end

  def load_question
    @question = Question.find(params[:question_id])
  end
end
