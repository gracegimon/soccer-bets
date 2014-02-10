class UsersController < ApplicationController
  before_action :signed_in, only: [:show]
  
  def show
    @user = User.find(params[:id])
    @score_boards = @user.score_boards
    if @score_boards.empty?
      @score_boards = @user.score_boards_admin
    end
  end

  private

    def signed_in
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

end
