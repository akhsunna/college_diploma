class AddOwnerRefToItems < ActiveRecord::Migration
  def change
    add_column :items, :parent_id, :integer

    add_reference :items, :subject, index: true
    add_foreign_key :items, :subjects
  end
end
