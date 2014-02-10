class ScoreBoardsController < ApplicationController
  before_filter :authenticate
  before_action :check_admin, only: [:tournament_score_board]

  def index
    @score_boards = current_user.score_boards
  end
  
  def show
    @score_board = ScoreBoard.find(params[:id])
    @user = @score_board.user
    @groups = current_tournament.groups
  end

  def tournament_score_board
    @tournament = Tournament.find(params[:id])
    @groups = @tournament.groups
    @score_board = main_score_board
  end

  def create
    @user = User.find(params[:user_id])
    @score_board = @user.score_boards.create(params[:score_board].permit(:name,:board_type,:is_active))
    if @score_board.errors.empty?
      redirect_to user_score_board_path(@user,@score_board)
    else
      flash[:error] = @score_board.errors
      redirect_to @user
    end
  end
end
