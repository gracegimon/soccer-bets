class AuthenticationController < ApplicationController

  def sign_in
    @user = User.new
  end

  def login
    email = params[:user][:email]
    password = params[:user][:password]
    user = User.authenticate(email, password)
    if user
      session[:user_id] = user.id
      redirect_to :root, :notice => "You're logged in"
    else
      flash[:error] = "Please check your email and/or password"
      redirect_to :action => "sign_in"
    end

  end

  def signed_out
    session[:user_id] = nil
    flash[:notice] = "You have been signed out."
    redirect_to :root
  end

  def change_password

  end

  def forgot_password

  end

  def sign_up
    @user = User.new
  end

  def register
    @user = User.new(new_user_params)
    if @user.valid?
      @user.save
      session[:user_id] = @user.id
      flash[:notice] = "You've signed up !"
      redirect_to :root
    else
      flash[:error] = "This email has already been used "
      redirect_to sign_up_path
    end    
  end

  def password_sent

  end

  private

  def user_params
    params.require(:user).permit(:username,:password)
  end

  def new_user_params
    params.require(:user).permit(:username, :password, :password_confirmation, :email)
  end
end
