class ChangeNamesToProperties < ActiveRecord::Migration
  def change
  	table = :matches
  	remove_column table, :type
  	add_column table, :match_type, :integer
  	table = :score_boards
  	remove_column table, :type
  	add_column table, :board_type, :integer
  	table = :tournaments
  	remove_column table, :type
  	add_column table, :tournament_type, :integer
  end
end
