class AddScoreBoardIdToTeamStats < ActiveRecord::Migration
  def change
  	add_column :team_stats, :score_board_id, :integer
  end
end
