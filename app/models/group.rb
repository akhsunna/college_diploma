class Group < ActiveRecord::Base
  validates :name, presence: true

  belongs_to :speciality
  has_many :users
  has_many :group_subjects, dependent: :delete_all
  has_many :subjects, through: :group_subjects

  has_many :invite_codes
end
