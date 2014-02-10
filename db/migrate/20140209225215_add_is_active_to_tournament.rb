class AddIsActiveToTournament < ActiveRecord::Migration
  def change
  	add_column :tournaments, :is_active, :integer
  end
end
