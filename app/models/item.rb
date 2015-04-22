class Item < ActiveRecord::Base
  belongs_to :item, class_name: 'Item'
  belongs_to :subject, class_name: 'Subject'

  validates :item_id, :subject_id, presence: true

  def root?
    item_id == 0
  end
end
