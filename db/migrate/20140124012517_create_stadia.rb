class CreateStadia < ActiveRecord::Migration
  def change
    create_table :stadia do |t|
      t.column :name, :string
      t.column :city, :string
      t.column :country, :string
      t.column :picture, :string
      t.column :capacity, :string
      t.column :home_team_id, :integer
      t.timestamps
    end
  end
end
