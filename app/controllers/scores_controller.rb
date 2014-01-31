class ScoresController < ApplicationController

  def create
    @score = Score.new(score_params)
    if @score.valid?
      @score.save
      flash[:notice] = "It was saved"
    else
      flash[:error] = "It already exists"
    end
  end

  private

  def score_params
    params.require(:score).permit(:team_1_goals, :team_2_goals, :scoreboard_id, :match_id)
  end

end
