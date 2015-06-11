class CreateFavFiles < ActiveRecord::Migration
  def up
    create_table :fav_files do |t|
      t.references :user, :null => false
      t.references :sub_file, :null => false
    end
  end

  def down
    drop_table :fav_files
  end
end
