class CreateFavFolders < ActiveRecord::Migration
  def up
    create_table :fav_folders, :id => false do |t|
      t.references :user, :null => false
      t.references :folder, :null => false
    end
    add_foreign_key :fav_folders, :users
    add_foreign_key :fav_folders, :folders
  end

  def down
    drop_table :fav_folders
  end
end
