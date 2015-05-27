class CreateFavFiles < ActiveRecord::Migration
  def up
    create_table :fav_files, :id => false do |t|
      t.references :user, :null => false
      t.references :sub_file, :null => false
    end
    add_foreign_key :fav_files, :users
    add_foreign_key :fav_files, :sub_files
  end

  def down
    drop_table :fav_files
  end
end
