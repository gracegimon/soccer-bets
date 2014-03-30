class ExtraPhasesController < ApplicationController

  def create
    binding.pry
  end

  def get_teams
  	@teams = Team.all
  	result = []
  	@teams.each do |team|
  		result << {id: team.id, label: team.name}
  	end
  	render json: result.to_json
  end

  private

  def extra_phase_params
    params.require(:score).permit(:red_card_team_id, :penal_team_id, :score_board_id, :best_player_id) 
  end   
end
