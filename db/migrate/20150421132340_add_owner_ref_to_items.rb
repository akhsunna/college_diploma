class AddOwnerRefToItems < ActiveRecord::Migration
  def change
    add_reference :items, :item, index: true
    add_foreign_key :items, :items

    add_reference :items, :subject, index: true
    add_foreign_key :items, :subjects
  end
end
