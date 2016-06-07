class QuestionsController < ApplicationController
  include Voted

  before_action :authenticate_user!, except: [:index, :show ]
  before_action :load_question, only: [:show, :edit, :update, :destroy, :vote]
  before_action :build_association_objects, only: :show


  respond_to :js
  respond_to :json, only: [:create]
  
  def index
    respond_with(@questions = Question.all)
  end
  
  def show
    respond_with @question
  end
  
  def new
    respond_with(@question = Question.new)
  end
  
  def edit; end
  
  def create 
    respond_with(@question = Question.create(question_params.merge(user: current_user)))
    PrivatePub.publish_to "/questions", question: @question.to_json if @question.valid?
  end
  
  def update
    @question.update(question_params)
    respond_with @question
  end
  
  def destroy
    if current_user.author_of?(@question)
      respond_with(@question.destroy)
    else
      render :show
    end
  end 

  private
  
  def load_question
    question_id = params[:id] || params[:question_id]
    @question = Question.find(question_id)
  end
  
  def question_params
    params.require(:question).permit(:body, :title, 
      attachments_attributes: [:id,:file, :_destroy])
  end

  def build_association_objects
    @answer = Answer.new
    @comment = Comment.new
  end
end
