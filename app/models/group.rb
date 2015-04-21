class Group < ActiveRecord::Base
  validates :short_name, presence: true
  validates :name, presence: true
end
