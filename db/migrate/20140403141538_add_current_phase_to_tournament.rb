class AddCurrentPhaseToTournament < ActiveRecord::Migration
  def change
  	add_column :tournaments, :current_phase, :integer
  end
end
