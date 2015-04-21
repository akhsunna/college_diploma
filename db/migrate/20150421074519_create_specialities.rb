class CreateSpecialities < ActiveRecord::Migration

  def up
    create_table :specialities do |t|

      t.string :short_name, null: false
      t.string :name

      t.timestamps
    end
  end

  def down
    drop_table :specialities
  end

end
