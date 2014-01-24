class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.column :team_1_goals, :integer
      t.column :team_2_goals, :integer
      t.column :winner_team_id, :integer
      t.column :scoreboard_id, :integer
      t.column :match_id, :integer
      t.timestamps
    end
  end
end
