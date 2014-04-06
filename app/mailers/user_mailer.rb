class UserMailer < ActionMailer::Base
  default from: "no-reply@tuquiniela2014.com.ve"

  def welcome_email(user)
    @user = user
    @site_name = "Tu Pote"
    mail(:to => user.email, :subject => "Bienvenido a TuQuiniela2014")
  end

  def reset_password_email(user)
    @user = user
    @password_reset_url = 'http://www.tuquiniela2014.com.ve/password_reset?' + @user.password_reset_token
    mail(:to => user.email, :subject => 'TuQuiniela2014: Instrucciones para reestablecer contraseña')
  end

  def you_should_pay(user, score_board)
    @user = user
    @score_board = score_board
    mail(:to => user.email, :subject => "TuQuiniela2014: Tu Quiniela ha sido completada")
  end

  def you_are_active(user, score_board)
    @user = user
    @site_name = "Tu Pote"
    @score_board = score_board
    mail(:to => user.email, :subject => "TuQuiniela2014: Tu Quiniela está activa")
  end
end
