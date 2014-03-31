class ExtraPhasesController < ApplicationController

  def create
    @extra_phase = ExtraPhase.new(extra_phase_params)
    exists = extra_phase_exists(@extra_phase)
    if exists.empty?
      if @extra_phase.valid?
        @extra_phase.save
        flash[:success] = "Guardado"
      end
    else
      exists.first.update_attributes(extra_phase_params)
    end
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
    params.require(:extra_phase).permit(:red_card_team_id, :penal_team_id, :score_board_id, :best_player_id) 
  end

  def extra_phase_exists(extra_phase)
    ExtraPhase.where(score_board_id: extra_phase.score_board_id)
  end

end
