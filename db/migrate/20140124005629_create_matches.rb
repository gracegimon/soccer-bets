class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
    	t.column :team_1_id, :integer
    	t.column :team_2_id, :integer
    	t.column :type, :string
    	t.column :date, :date
    	t.column :city, :string
    	t.column :stadium, :string
      t.timestamps
    end
  end
end
