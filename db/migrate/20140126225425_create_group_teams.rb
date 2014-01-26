class CreateGroupTeams < ActiveRecord::Migration
  def change
    create_table :group_teams do |t|
      t.belongs_to :group
      t.belongs_to :team
      t.timestamps
    end
  end
end
