class CreateGroupMatches < ActiveRecord::Migration
  def change
    create_table :group_matches do |t|
      t.belongs_to :group
      t.belongs_to :match
      t.timestamps
    end
  end
end
