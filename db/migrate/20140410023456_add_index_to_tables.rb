class AddIndexToTables < ActiveRecord::Migration
  def change
  	add_index :score_boards, :user_id
  	add_index :score_boards, :is_active
  	add_index :score_boards, :points, order: {points: :desc}
  	add_index :scores, :match_id
  	add_index :team_stats, :score_board_id
  	add_index :teams, :name
  	add_index :users, :email
  	add_index :extra_phases, :score_board_id
  	add_index :matches, :score_board_id
  	add_index :matches, :match_type
  	add_index :players, :name
  end
end
