class ExtraPhasesController < ApplicationController

  def create
    binding.pry
  end

  def get_teams
  	@teams = Team.where("name LIKE :prefix", prefix: "#{params[:term].camelcase}%") 
    result = []
  	@teams.each do |team|
  		result << {label: team.name, id: team.id}
  	end
  	render json: result.to_json
  end

  private

  def extra_phase_params
    params.require(:score).permit(:red_card_team_id, :penal_team_id, :score_board_id, :best_player_id) 
  end   
end
