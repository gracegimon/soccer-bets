class CreateScoreBoards < ActiveRecord::Migration
  def change
    create_table :score_boards do |t|
      t.column :name, :text
      t.column :user_id, :integer
      t.column :position, :integer
      t.column :points, :integer
      t.column :type, :integer
      t.column :is_active, :boolean
      t.timestamps
    end
  end
end
