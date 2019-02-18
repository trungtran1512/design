class HomePagesController < ApplicationController
  
  def index
    @colors = Color.all
    @users = User.all
  end
end
