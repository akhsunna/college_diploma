class Group < ActiveRecord::Base
  validates :short_name, presence: true
  validates :name, presence: true

  belongs_to :speciality
  has_many :users
end
