class CreateRoles < ActiveRecord::Migration
  def up
    create_table :roles do |t|
      t.string :name, null: false
    end

    add_reference :users, :role, index: true
    add_foreign_key :users, :roles
  end

  def down
    drop_table :roles
    remove_column :users, :role
  end
end
