class HomePagesController < ApplicationController
  
  def index
    @colors = Color.all
    @users = User.all
    @q = Post.ransack(params[:q])
    if @query.present?
      @posts = @q.result(distinct: true).sort_time
    else
      @posts = Post.all.sort_time
    end
  end
end
