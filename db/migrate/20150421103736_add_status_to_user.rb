class AddStatusToUser < ActiveRecord::Migration
  def up
    add_column :users, :status, :integer
  end

  def down
    remove_column :users, :status
  end
end
