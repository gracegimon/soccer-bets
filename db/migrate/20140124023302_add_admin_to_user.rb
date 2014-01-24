class AddAdminToUser < ActiveRecord::Migration
  def change
    table = :users
    add_column table, :is_admin, :boolean
  end
end
