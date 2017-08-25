class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @posts = Post.all.reverse
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.create(post_params)
    @post.user = current_user
    @post.save
    redirect_to posts_url
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
  end

  def destroy
    Post.find(params[:id]).delete
  end

  private

  def post_params
    params.require(:post).permit(:message)
  end
end
