class DeleteColumn < ActiveRecord::Migration
  def change
    table = :teams
    remove_column table, :group_id, :integer
  end
end
