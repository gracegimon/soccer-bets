class CreateTeamStats < ActiveRecord::Migration
  def change
    create_table :team_stats do |t|
    	t.column :team_id, :integer
    	t.column :points, :integer
    	t.column :status, :integer
    	t.column :played_games, :integer
    	t.column :won_games, :integer
    	t.column :tied_games, :integer
    	t.column :goals_favor, :integer
    	t.column :goals_aggainst, :integer
      t.timestamps
    end
  end
end
