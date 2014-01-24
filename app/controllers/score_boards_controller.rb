class ScoreBoardsController < ApplicationController

  def show
    @score_board = ScoreBoard.find(params[:id])
    @user = @score_board.user
  end

  def create
  	@user = User.find(params[:user_id])
  	@score_board = @user.score_boards.create(params[:score_board].permit(:name,:position))
  	redirect_to user_score_board_path(@user,@score_board)

  end
end
