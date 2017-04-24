class PostsController < ApplicationController
  before_action :require_user_is_author_of_post, only: [:edit, :update]
  before_action :require_login

  def require_user_is_author_of_post
    return if current_user.posts.find_by(id: params[:id])
    render json: "Forbidden", status: :forbidden
  end

  def new
    @post = Post.new
  end

  def create

    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to post_url(@post)
    else
      flash[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])

    if @post.update_attributes(post_params)
      redirect_to post_url(@post)
    else
      flash[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.delete
    redirect_to sub_url(@post.sub)
  end

  def show
    @post = Post.find(params[:id])
  end

  private
  def post_params
    params.require(:post).permit(:title, :url, :content, sub_ids: [])
  end
end
