class AddGroupIdToTeams < ActiveRecord::Migration
  def change
    table = :teams
    add_column table, :group_id, :integer
  end
end
