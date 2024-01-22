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
end
