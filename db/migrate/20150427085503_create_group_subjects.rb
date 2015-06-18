class CreateGroupSubjects < ActiveRecord::Migration
  def up
    create_table :group_subjects do |t|
      t.references :group, :null => false
      t.references :subject, :null => false
    end
  end

  def down
    drop_table :group_subjects
  end
end
