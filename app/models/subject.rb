class Subject < ActiveRecord::Base
  validates :short_name, presence: true
  validates :name, presence: true

  belongs_to :user
end
