class Folder < ActiveRecord::Base
  belongs_to :parent, class_name: 'Folder'
  belongs_to :subject, class_name: 'Subject'

  has_many :folders
  has_many :sub_files

  has_many :fav_folders, dependent: :delete_all

  def root?
    parent_id == nil
  end
end
