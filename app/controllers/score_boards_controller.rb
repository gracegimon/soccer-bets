class ScoreBoardsController < ApplicationController
  before_filter :authenticate 
  def show
    @score_board = ScoreBoard.find(params[:id])
    @user = @score_board.user
  end

  def create
    @user = User.find(params[:user_id])
    @score_board = @user.score_boards.create(params[:score_board].permit(:name,:board_type,:is_active))
    binding.pry
    if @score_board.errors.empty?
      redirect_to user_score_board_path(@user,@score_board)
    else
      flash[:error] = @score_board.errors
      redirect_to @user
    end
  end
end
