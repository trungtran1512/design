class HomePagesController < ApplicationController
  
  def index
    @colors = Color.all
    @users = User.all
    @post = Post.all.order(created_at: :desc)
  end
end
