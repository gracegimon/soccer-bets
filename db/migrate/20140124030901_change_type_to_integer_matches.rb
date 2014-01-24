class ChangeTypeToIntegerMatches < ActiveRecord::Migration
  def change
  	table = :matches
  	remove_column table, :type
  	add_column table, :type, :integer
  end
end
