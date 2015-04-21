class Speciality < ActiveRecord::Base
  validates :name, presence: true

  has_many :groups
end
