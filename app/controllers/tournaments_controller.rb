class TournamentsController < ApplicationController

  def show
    @tournament = Tournament.find(params[:id])
    @groups = @tournament.groups
    @score_board = main_score_board
  end
end
