class ChangeStadiumColumn < ActiveRecord::Migration
  def change
    table = :matches
    remove_column table, :stadium
    add_column table, :stadium_id, :integer
  end
end
