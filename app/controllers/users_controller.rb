class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy]

  def index
    if user_signed_in?
      @user_posts = current_user.posts.sort_time.page(params[:page]).per(9)
    else
      redirect_to new_user_session_path
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:admin, :password, :email, :username, :location, :fullname, :phone, :avatar)
  end
end
