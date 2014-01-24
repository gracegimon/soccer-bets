class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.column :country, :string
      t.column :country_ab, :string
      t.column :flag, :string 
      t.timestamps
    end
  end
end
