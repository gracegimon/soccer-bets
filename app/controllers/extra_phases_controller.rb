class ExtraPhasesController < ApplicationController

  def create

  end

  def get_teams
  	@teams = Team.all
  	result = []
  	@teams.each do |team|
  		result << {id: team.id, label: team.name}
  	end
  	render json: result.to_json
  end

end
