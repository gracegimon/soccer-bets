class UserMailer < ActionMailer::Base
  default from: "no-reply@tupote.com.ve"

  def welcome_email(user)
    @user = user
    @site_name = "Tu Pote"
    mail(:to => user.email, :subject => "Bienvenido a TuPote")
  end

  def reset_password_email(user)
    @user = user
    @password_reset_url = 'http://www.tupote.com.ve/password_reset?' + @user.password_reset_token
    mail(:to => user.email, :subject => 'TuPote: Instrucciones para reestablecer contraseña')
  end

  def you_should_pay(user, score_board)
    @user = user
    @score_board = score_board
    mail(:to => user.email, :subject => "TuPote: Tu Quiniela ha sido completada")
  end

  def you_are_active(user, score_board)
    @user = user
    @site_name = "Tu Pote"
    @score_board = score_board
    mail(:to => user.email, :subject => "TuPote: Tu Quiniela está activa")
  end
end
