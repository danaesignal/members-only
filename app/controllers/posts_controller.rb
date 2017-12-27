class PostsController < ApplicationController
  before_action :access_control, only: [:new, :create]

  def new
    @user = current_user
    @post = @user.posts.new
  end

  def create
    @user = current_user
    @post = @user.posts.new(post_params)
    if @user && @post && @post.save
      redirect_to posts_path
    else
      render root_path
    end
  end

  def index
    @posts = Post.all
  end

  private

  def access_control
    redirect_to root_path unless logged_in?
  end

  def post_params
    params.require(:post).permit(:content)
  end
end
