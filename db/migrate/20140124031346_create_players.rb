class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.column :first_name, :string
      t.column :last_name, :string
      t.column :date_of_birth, :date
      t.column :position, :string
      t.column :shirt_number, :integer
      t.column :team_id, :integer
      t.timestamps
    end
  end
end
