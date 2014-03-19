class CreateExtraPhases < ActiveRecord::Migration
  def change
    create_table :extra_phases do |t|
      t.belongs_to :score_board
      t.column :penal_team_id, :integer
      t.column :red_card_team_id, :integer
      t.column :best_player_id, :integer
      t.timestamps
    end
  end
end
