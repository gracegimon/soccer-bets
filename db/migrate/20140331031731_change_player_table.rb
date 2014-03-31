class ChangePlayerTable < ActiveRecord::Migration
  def change
  	table = :players
  	remove_column table, :last_name
  	remove_column table, :first_name
  	add_column table, :name, :string
  end
end
