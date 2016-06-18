class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    authorize Comment
    load_commentable
    @comment = Comment.new(comment_params.merge({ user: current_user }))
    @commentable.comments << @comment
    respond_to do |format|
      format.js do
        if @comment.save && @commentable.save
          load_question
          PrivatePub.publish_to "/question/#{@question.id}/comments",
            { comment: @comment.to_json, method: :create }
          render nothing: true
        else
          # render js template
        end
      end
    end
  end

  def destroy
    load_comment
    load_question
    authorize @comment
    respond_to do |format|
      format.js do
        if current_user.author_of?(@comment) && @comment.destroy
          PrivatePub.publish_to "/question/#{@question.id}/comments",
            { comment: @comment.to_json, method: :destroy }
        end
        render nothing: true
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def load_comment
    comment_id = params[:id]
    @comment = Comment.find(comment_id)
  end

  def load_commentable
    klass = params.keys.detect { |key| key =~ /(question|answer)_id/  }
      .gsub("_id","")
      .capitalize
    klass_id = params[:question_id] || params[:answer_id]
    klass = klass.classify.constantize
    @commentable = klass.find(klass_id)
  end

  def load_question
    if @comment.commentable.class == Question
      @question = @comment.commentable
    else
      @question = @comment.commentable.question
    end
  end
end
