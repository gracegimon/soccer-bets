class ScoreBoardsController < ApplicationController
  before_filter :authenticate
  before_action :check_admin, only: [:tournament_score_board, :show_for_admin]

  def index
    @score_boards = current_user.score_boards
  end
  
  def show
    @score_board = ScoreBoard.find(params[:id])
    @user = @score_board.user
    @groups = current_tournament.groups
  end

  def show_for_admin
    @score_boards_not_active = ScoreBoard.where(is_active: false, is_published: true)
    @score_boards_active = ScoreBoard.where(is_active: true, is_published: true)
  end

  def tournament_score_board
    @tournament = Tournament.find(params[:id])
    @groups = @tournament.groups
    @score_board = main_score_board
  end

  def ranking
    @score_boards = ScoreBoard.not_main_board.order(points: :desc)
  end

  def create
    @user = User.find(params[:user_id])
    @score_board = @user.score_boards.create(params[:score_board].permit(:name,:board_type,:is_active, :tournament_id))
    if @score_board.errors.empty?
      redirect_to user_score_board_path(@user,@score_board)
    else
      flash[:error] = @score_board.errors
      redirect_to @user
    end
  end
end
