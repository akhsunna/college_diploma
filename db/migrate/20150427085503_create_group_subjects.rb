class CreateGroupSubjects < ActiveRecord::Migration
  def up
    create_table :group_subjects, :id => false do |t|
      t.references :group, :null => false
      t.references :subject, :null => false
    end
    add_foreign_key :group_subjects, :groups
    add_foreign_key :group_subjects, :subjects
  end

  def down
    drop_table :group_subjects
  end
end
