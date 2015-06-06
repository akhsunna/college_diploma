class CreateFavFolders < ActiveRecord::Migration
  def up
    create_table :fav_folders do |t|
      t.references :user, :null => false
      t.references :folder, :null => false
    end
  end

  def down
    drop_table :fav_folders
  end
end
