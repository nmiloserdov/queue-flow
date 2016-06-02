class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    load_commentable
    @comment = Comment.new(comment_params.merge({ user: current_user }))
    respond_to do |format|
      if @comment.save
        format.js do
          @commentable.comments.push(@comment)
          @commentable.save
          PrivatePub.publish_to "/#{@comment.commentable_type}/"\
            "#{@comment.commentable_id}", comment: @comment.to_json
            render nothing: true
        end
      else
        format.js
      end
    end
  end

  def destroy
    load_comment
    current_user.author_of?(@comment) || @comment.destroy
  end

  private

  def load_comment
    comment_id = params[:id]
    @comment = Comment.find(comment_id)
  end

  def load_commentable
    commentable = self.request.fullpath
      .scan(/(answers|questions)/).first[0]
    commentable_id = params[:question_id] || params[:answer_id]
    klass = commentable.classify.constantize
    @commentable = klass.find(commentable_id)
  end

  def comment_params
    params.require(:comment).permit(:body, :commentable_id, :commentable_type)
  end
end
