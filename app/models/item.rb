class Item < ActiveRecord::Base
  belongs_to :parent, class_name: 'Item'
  has_many :items
  belongs_to :subject, class_name: 'Subject'
end
