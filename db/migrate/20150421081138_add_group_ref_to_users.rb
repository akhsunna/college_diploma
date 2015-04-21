class AddGroupRefToUsers < ActiveRecord::Migration
  def change
    add_reference :users, :group, index: true
    add_foreign_key :users, :groups
  end
end
