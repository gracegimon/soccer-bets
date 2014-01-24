class CreateTournaments < ActiveRecord::Migration
  def change
    create_table :tournaments do |t|
      t.column :name, :string
      t.column :number, :string
      t.column :type, :string
      t.column :start_date, :date
      t.column :end_date, :date
      t.column :country, :string
      t.timestamps
    end
  end
end
