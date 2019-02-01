class UserMailer < ApplicationMailer
	default from: "from@example.com"

	  def user_email user
    @user = user
    mail to: @user.email, subject: "Sample Email"
  end
end
