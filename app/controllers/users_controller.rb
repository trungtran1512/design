class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy]

  def index
    if user_signed_in?
      @user = current_user
    else
      redirect_to new_user_session_path
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:admin, :password, :email, :username, :location, :fullname, :phone)
  end
end
