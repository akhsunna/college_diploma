class AddColumnToSubFile < ActiveRecord::Migration
  def up
    add_column :sub_files, :path_viewing, :string
  end

  def down
    remove_column :sub_files, :path_viewing
  end
end
