class AddOwnerRefToItems < ActiveRecord::Migration
  def change
    add_column :folders, :parent_id, :integer

    add_reference :folders, :subject, index: true
    add_foreign_key :folders, :subjects
  end
end
