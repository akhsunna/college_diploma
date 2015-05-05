class SubFile < ActiveRecord::Base
  belongs_to :parent, class_name: 'Folder'
  belongs_to :subject, class_name: 'Subject'

  has_attached_file :content, :path => ':rails_root/uploads/:subject_id/:id'
  do_not_validate_attachment_file_type :content

  validates_attachment_presence :content, :message => 'Blank'
  validates_presence_of :parent_id
  validates_uniqueness_of :content_file_name, :scope => 'parent_id', :message => 'Exists already'
  validates_format_of :content_file_name, :with => /\A[^\/\\\?\*:|"<>]+\z/, :message => 'Invalid characters'

  def name
    content_file_name
  end

end
