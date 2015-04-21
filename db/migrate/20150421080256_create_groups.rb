class CreateGroups < ActiveRecord::Migration

  def up
    create_table :groups do |t|

      t.string :name, null: false
      t.integer :course

      t.timestamps
    end

    add_reference :groups, :speciality, index: true
    add_foreign_key :groups, :specialities
  end

  def down
    drop_table :groups
  end

end
