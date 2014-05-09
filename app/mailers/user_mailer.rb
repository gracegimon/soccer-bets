class UserMailer < ActionMailer::Base
  #default from: "quinielatupote@gmail.com"
  default from: "no-reply@2014bracket.net"

  def welcome_email(user)
    @user = user
    @site_name = "Bracket 2014"
    mail(:to => user.email, :subject => "Welcome to Bracket2014")
  end

  def reset_password_email(user)
    @user = user
    @password_reset_url = 'http://www.2014bracket.net/password_reset?' + @user.password_reset_token
    mail(:to => user.email, :subject => 'Bracket2014: Instructions to change password')
  end

  def you_should_pay(user, score_board)
    @user = user
    @score_board = score_board
    mail(:to => user.email, :subject => "Bracket2014: Your pool has been completed")
  end

  def you_are_active(user, score_board)
    @user = user
    @site_name = "Bracket 2014"
    @score_board = score_board
    mail(:to => user.email, :subject => "Bracket2014: Your pool is active")
  end
end
