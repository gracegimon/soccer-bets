class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.column :name, :string
      t.column :first_place_team_id, :integer
      t.column :second_place_team_id, :integer
      t.timestamps
    end
  end
end
