class Folder < ActiveRecord::Base
  belongs_to :parent, class_name: 'Folder'
  has_many :folders
  belongs_to :subject, class_name: 'Subject'
  #
  #
  # has_attached_file :content, path: ':rails_root/uploads/:subject_id'
  # do_not_validate_attachment_file_type :content
  # validates_attachment_size :content, :less_than => 10.megabytes
  # validates_format_of :content_file_name, with: /\A[^\/\\\?\*:|"<>]+\z/, message: 'invalid characters'

  def root?
    parent_id == nil
  end
end
