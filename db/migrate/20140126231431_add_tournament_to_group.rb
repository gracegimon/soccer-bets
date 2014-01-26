class AddTournamentToGroup < ActiveRecord::Migration
  def change
  	table = :groups
  	add_column table, :tournament_id, :integer
  end
end
