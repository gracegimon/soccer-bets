class AddTournamentToScoreBoard < ActiveRecord::Migration
  def change
  	add_column :score_boards, :tournament_id, :integer
  end
end
