class AddLostGameToTeamStat < ActiveRecord::Migration
  def change
  	add_column :team_stats, :lost_games, :integer
  end
end
