class AddCanChangeToScores < ActiveRecord::Migration
  def change
  	add_column :scores, :can_change, :boolean
  end
end
