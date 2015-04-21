class Speciality < ActiveRecord::Base
  validates :name, presence: true
end
