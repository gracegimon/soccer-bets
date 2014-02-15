class AddTeamStatPosition < ActiveRecord::Migration
  def change
  	add_column :team_stats, :position, :integer
  end
end
