class CreateFolders < ActiveRecord::Migration
  def up
    create_table :folders do |t|
      t.string :name
      t.timestamps
    end
  end

  def down
    drop_table :folders
  end
end
