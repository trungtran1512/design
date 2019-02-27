class SearchController < ApplicationController
  
  def search
    if params[:q].nil?
      @posts = []
    else
      byebug
      @posts = Post.search params[:q]
    end
  end
end