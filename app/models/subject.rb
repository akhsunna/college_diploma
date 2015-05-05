class Subject < ActiveRecord::Base
  validates :short_name, presence: true
  validates :name, presence: true

  belongs_to :user
  has_many :group_subjects
  has_many :groups, through: :group_subjects
  has_many :folders
end
