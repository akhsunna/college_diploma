class SubFile < ActiveRecord::Base
  belongs_to :parent, class_name: 'Folder'
  belongs_to :subject, class_name: 'Subject'

  has_attached_file :content, :url => '/files/:filename', path: ':rails_root/public/files/:filename'
  do_not_validate_attachment_file_type :content

  validates_attachment_presence :content, :message => 'Blank'
  validates_presence_of :parent_id
  validates_uniqueness_of :content_file_name, :scope => 'parent_id', :message => 'Exists already'
  validates_format_of :content_file_name, :with => /\A[^\/\\\?\*:|"<>]+\z/, :message => 'Invalid characters'

  def name
    content_file_name
  end

  IMAGE_TYPES = ['png','jpeg','jpg','']
  DOC_TYPES = ['doc','docx','msword']
  CODE_TYPES = ['rb','py','javascript','js','octet-stream']
  VIDEO_TYPES = ['mp4']
  AUDIO_TYPES = ['mp3']
  ARCHIVE_TYPES = ['rar','x-rar','zip']

  def format
    t = content_content_type.split('/').last
    if IMAGE_TYPES.include?(t)
      'image'
    elsif DOC_TYPES.include?(t)
      'document'
    elsif CODE_TYPES.include?(t)
      'code'
    elsif VIDEO_TYPES.include?(t)
      'video'
    elsif AUDIO_TYPES.include?(t)
      'audio'
    elsif ARCHIVE_TYPES.include?(t)
      'archive'
    else
      'file'
    end
  end

end
