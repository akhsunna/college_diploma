class AddRootToSubject < ActiveRecord::Migration
  def up
    add_column :subjects, :root_id, :integer
  end

  def down
    remove_column :subjects, :root_id
  end
end
