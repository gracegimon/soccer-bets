class AddScoreBoardIdToMatch < ActiveRecord::Migration
  def change
  	add_column :matches, :score_board_id, :integer
  end
end
