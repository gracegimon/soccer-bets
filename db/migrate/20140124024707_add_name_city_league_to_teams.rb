class AddNameCityLeagueToTeams < ActiveRecord::Migration
  def change
  	table = :teams
  	add_column table, :name, :string
  	add_column table, :city, :string
  	add_column table, :league, :string
  end
end
