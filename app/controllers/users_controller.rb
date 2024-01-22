class UsersController < ApplicationController
  def index
    # Fetch and display a list of users
    @users = User.all
  end

  def posts
    # Fetch and display posts for a specific user
    @user = User.find(params[:id])
    @posts = @user.posts
  end
end
