class Group < ActiveRecord::Base
  validates :short_name, presence: true
  validates :name, presence: true

  belongs_to :speciality
  has_many :users
  has_many :group_subjects, dependent: :delete_all
  has_many :subjects, through: :group_subjects
end
