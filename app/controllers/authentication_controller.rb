class AuthenticationController < ApplicationController

  def sign_in
    @user = User.new
  end

  def login
    username_or_email = params[:user][:username]
    password = params[:user][:password]
    if username_or_email.rindex('@')
      email=username_or_email
      user = User.authenticate_by_email(email, password)
    else
      username=username_or_email
      user = User.authenticate_by_username(username, password)
    end
    if user
      redirect_to :root, :notice => "You're logged in"
    else
      flash[:error] = "Please check your username and/or password"
      redirect_to :action => "sign_in"
    end

  end

  def signed_out

  end

  def change_password

  end

  def forgot_password

  end

  def sign_up
    @user = User.create!(user_params)
    @user.save
    redirect_to :root
  end

  def password_sent

  end

  private

  def user_params
    params.require(:user).permit(:username,:password)
  end
end
