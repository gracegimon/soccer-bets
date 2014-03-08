class ScoresController < ApplicationController

  def create
    @score = Score.new(score_params)
    if score_exists(@score).empty?
      if @score.valid?
        @score.save
        flash[:notice] = "It was saved"
      else
        flash[:error] = "Something unexpected happened"
      end
    else
      @score = score_exists(@score).first
      if @score.update_attributes(score_params)
        flash[:notice] = "Good"
      end
    end
  end

  def update
    @score = Score.find(params[:id]) unless params[:id].nil?
    if @score.update_attributes(score_params)
      flash[:notice] = "Good"
    end
  end

  def edit
    flash[:notice] = "Edit"
  end

  private

  def score_params
    params.require(:score).permit(:team_1_goals, :team_2_goals, :scoreboard_id, :match_id)
  end

  def score_exists(score)
    Score.where(scoreboard_id: score.scoreboard_id, match_id: score.match_id)
  end
end
