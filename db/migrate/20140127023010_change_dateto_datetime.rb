class ChangeDatetoDatetime < ActiveRecord::Migration
  def change
  	table = :matches
  	remove_column table, :date
  	add_column table, :date, :datetime
  end
end
