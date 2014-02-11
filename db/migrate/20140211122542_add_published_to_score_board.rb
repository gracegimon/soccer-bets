class AddPublishedToScoreBoard < ActiveRecord::Migration
  def change
  	add_column :score_boards, :is_published, :boolean
  end
end
