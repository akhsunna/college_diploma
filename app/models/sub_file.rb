class SubFile < ActiveRecord::Base
  belongs_to :parent, class_name: 'Folder'
  belongs_to :subject, class_name: 'Subject'

  has_many :fav_files, dependent: :delete_all

  has_attached_file :content, :url => '/files/:id/:filename', path: ':rails_root/public/files/:id/:filename'
  do_not_validate_attachment_file_type :content

  validates_attachment_presence :content, :message => 'Blank'
  validates_presence_of :parent_id
  validates_uniqueness_of :content_file_name, :scope => 'parent_id', :message => 'Exists already'
  validates_format_of :content_file_name, :with => /\A[^\/\\\?\*:|"<>]+\z/, :message => 'Invalid characters'

  def name
    content_file_name
  end

  IMAGE_TYPES = ['png','jpeg','jpg']
  DOC_TYPES = ['doc','docx','msword']
  CODE_TYPES = ['rb','py','javascript','js','octet-stream']
  VIDEO_TYPES = ['mp4']
  AUDIO_TYPES = ['mp3']
  ARCHIVE_TYPES = ['rar','x-rar','zip']
  PRESENTATION_TYPES = ['vnd.openxmlformats-officedocument.presentationml.presentation', 'vnd.ms-powerpoint']

  def format
    t = content_content_type.split('/').last
    if IMAGE_TYPES.include?(t)
      'image'
    elsif DOC_TYPES.include?(t)
      'document'
    elsif PRESENTATION_TYPES.include?(t)
      'presentation'
    elsif t == 'pdf'
      'pdf'
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

  def format_ua
    t = content_content_type.split('/').last
    if IMAGE_TYPES.include?(t)
      'зображення'
    elsif DOC_TYPES.include?(t)
      'документ'
    elsif PRESENTATION_TYPES.include?(t)
      'презентація'
    elsif t == 'pdf'
      'документ'
    elsif CODE_TYPES.include?(t)
      'код'
    elsif VIDEO_TYPES.include?(t)
      'відео'
    elsif AUDIO_TYPES.include?(t)
      'аудіо'
    elsif ARCHIVE_TYPES.include?(t)
      'архів'
    else
      'файл'
    end
  end


  def favourite? (user)
    FavFile.any?{ |item| item.sub_file_id==id && item.user_id==user.id }
  end


end
