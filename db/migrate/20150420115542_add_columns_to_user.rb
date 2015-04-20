class AddColumnsToUser < ActiveRecord::Migration
  def up
    add_column :users, :name, :string
    add_column :users, :full_name, :string
  end

  def down
    remove_column :users, :name
    remove_column :users, :full_name
  end
end
