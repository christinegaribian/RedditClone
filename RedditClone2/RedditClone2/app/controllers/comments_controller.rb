class CommentsController < ApplicationController
  def new
  end

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to post_url(@commet.post)
    else
      flash[:errors] = @comment.errors.full_messages
      render :new
    end
  end

  private
  def comment_params
    submission = params.require(:comment).permit(:content, :post_id)
    submission[:user_id] ||= current_user.id
    submission
  end
end
