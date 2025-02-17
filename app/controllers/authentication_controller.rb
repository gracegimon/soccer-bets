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
      redirect_to user, :notice => "Listo! Bienvenido de nuevo!"
    else
      flash[:error] = "Por favor, verifica tu usuario o contraseña"
      redirect_to :action => "sign_in"
    end

  end

  def signed_out
    session[:user_id] = nil
    flash[:notice] = "Has cerrado sesión"
    redirect_to :root
  end

  def change_password

  end

  def forgot_password
    @user = User.new
  end

  def sign_up
    @user = User.new
  end

  def register
    @user = User.new(new_user_params)
    if @user.valid?
      @user.save
      session[:user_id] = @user.id
      UserMailer.welcome_email(@user).deliver
      flash[:notice] = " Bienvenido!"
      redirect_to @user
    else
      render "sign_up"
    end    
  end

  def send_password_reset_instructions
    email = params[:user][:username]
    user = User.find_by_email(email)
    if user
      user.password_reset_token = SecureRandom.urlsafe_base64
      user.password_expires_after = 24.hours.from_now
      user.save
      UserMailer.reset_password_email(user).deliver
      flash[:notice] = 'Instrucciones de cambio de contraseña han sido enviadas a su correo. Por favor, verifique.'
      redirect_to :sign_in  
    else
      @user = User.new
      # put the previous value back.
      @user.email = params[:user][:email]
      @user.errors[:email] = 'no es un usuario registrado.'
      flash[:notice] = 'Este correo no pertenece a un usuario registrado'
      redirect_to forgot_password_path
    end

  end


  def password_reset
    token = params.first[0]
    @user = User.find_by_password_reset_token(token)
    if @user.nil?
      flash[:error] = 'Usted no ha solicitado un cambio de contraseña.'
      redirect_to :root
      return
    end

    if @user.password_expires_after < DateTime.now
      clear_password_reset(@user)
      @user.save
      flash[:error] = 'Su solicitud de reinicio de contraseña expiró. Por favor, solicite una nueva.'
      redirect_to :forgot_password
    end

  end

  def new_password
    email = params[:user][:email]
    @user = User.find_by(email: email)

    if verify_new_password(params[:user])
      @user.update(new_password_params)
      @user.password = @user.new_password

      if @user.valid?
        clear_password_reset(@user)
        @user.save!
        flash[:notice] = 'Su contraseña ha sido reiniciada. Por favor, inicie sesión con su nueva contraseña.'
        redirect_to :sign_in
      else
        render :action => "password_reset"
      end
    else
      @user.errors[:new_password] = 'No puede ser vacía, debe ser igual a la confirmación y mínimo 6 caracteres .'
      render :action => "password_reset"
    end
  end


  private

  def user_params
    params.require(:user).permit(:username,:password)
  end

  def new_password_params
    params.require(:user).permit(:new_password, :new_password_confirmation)
  end

  def new_user_params
    params.require(:user).permit(:username, :password, :password_confirmation, :email)
  end

  def clear_password_reset(user)
    user.password_expires_after = nil
    user.password_reset_token = nil
  end

  def verify_new_password(passwords)
    result = true

    if passwords[:new_password].blank? || (passwords[:new_password] != passwords[:new_password_confirmation]) || (passwords[:new_password].length < 6)
      result = false
    end

    result
  end
end
