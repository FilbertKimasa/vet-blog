class PostsController < ApplicationController
  def index
    # Fetch and display posts with comments for a specific user
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:comments)
  end

  def show
    # Fetch and display a single post with its associated comments
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])
    @comments = @post.comments
  end

  def like
    @post = Post.find(params[:id])
    current_user.likes << @post unless current_user.likes.include?(@post)
    redirect_to @post
  end
end
