class ChangeColumnScoreBoard < ActiveRecord::Migration
  def change
  	table = :score_boards
  	remove_column table, :name
  	add_column table, :name, :text
  end
end
