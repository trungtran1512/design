class HomePagesController < ApplicationController
  
  def index
    @colors = Color.all
    @users = User.all
    @q = Post.ransack(params[:q])
    if @query.present?
      @posts = @q.result(distinct: true).published.sort_time.page(params[:page]).per(12)
    else
      @posts = Post.published.sort_time.page(params[:page]).per(12)
    end
  end
end
