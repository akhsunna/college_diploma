class AddOwnerRefToItems < ActiveRecord::Migration
  def change
    add_column :folders, :parent_id, :integer
    add_reference :folders, :subject, index: true
  end
end
