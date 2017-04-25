class CommentsController < ApplicationController
  before_action :require_login

  def new
    @post = Post.find(params[:post_id])
    @comment = Comment.new
    @comment.post_id = @post.id
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.post_id = params[:post_id]

    if @comment.save
      redirect_to post_url(@comment.post)
    else
      flash[:errors] = @comment.errors.full_messages
      @post = Post.find(params[:post_id])
      render :new
    end
  end

  def show
    @comment = Comment.find(params[:id])
    @new_comment = Comment.new
    @new_comment.post = @comment.post
    @new_comment.parent_comment_id = @comment.id
  end

  private
  def comment_params
    submission = params.require(:comment).permit(:content, :parent_comment_id, :post_id)
    submission[:user_id] ||= current_user.id
    submission
  end
end
