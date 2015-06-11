class CreateSubFiles < ActiveRecord::Migration
  def up
    create_table :sub_files do |t|
      t.references :subject
      t.integer :parent_id
      t.attachment :content, null: false
      t.timestamps null: false
    end
  end

  def down
    drop_table :sub_files
  end
end
