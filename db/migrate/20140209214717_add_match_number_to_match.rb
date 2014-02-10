class AddMatchNumberToMatch < ActiveRecord::Migration
  def change
  	add_column :matches, :match_number, :integer
  end
end
