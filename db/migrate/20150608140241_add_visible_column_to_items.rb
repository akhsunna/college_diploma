class AddVisibleColumnToItems < ActiveRecord::Migration
  def up
    add_column :folders, :visible, :boolean
    add_column :sub_files, :visible, :boolean
  end

  def down
    remove_column :folders, :visible
    remove_column :sub_files, :visible
  end
end
