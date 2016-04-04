class QuestionsController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show ]
  before_action :load_question, only: [:show, :edit, :update, :destroy]
  
  def index
    @questions = Question.all
  end
  
  def show
    @answers = @question.answers
    @answer = Answer.new
    #@answer  = @question.answers.new
  end
  
  def new
    @question = Question.new
  end
  
  def edit; end
  
  def create 
    @question = Question.new(question_params.merge(user: current_user))
    if @question.save
      flash[:notice] = 'Your question successfully created.'
      redirect_to @question
    else
      flash[:error] = 'Your question not created.' 
      render :new 
    end
  end
  
  def update
    if @question.update(question_params)
      flash[:notice] = "Your question successfuly updated."
    else
      flash[:alert] = "Your question not updated."
    end
  end
  
  def destroy
    if current_user.author_of?(@question) and @question.destroy
      flash[:notice] = "Your question successfully deleted."
    else
      flash[:notice] = "You'r cant delete not your question."
    end
    redirect_to questions_path
  end 
  
  private
  
    def load_question
      @question = Question.find(params[:id])
    end
    
    def question_params
      params.require(:question).permit(:title,:body)
    end
end
