class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name, presence: true

  belongs_to :group

  has_many :fav_files
  has_many :fav_folders
  has_many :sub_files, through: :fav_files
  has_many :folders, through: :fav_folders

  ROLE_ADMIN = 'admin'
  ROLE_TEACHER = 'teacher'
  ROLE_STUDENT = 'student'

  def admin?
    role == ROLE_ADMIN
  end

  def teacher?
    role == ROLE_TEACHER
  end

  def student?
    role == ROLE_STUDENT
  end

  scope :teachers, ->{ where role: ROLE_TEACHER }
  scope :students, ->{ where role: ROLE_STUDENT }
  scope :users, ->{ where role: [ROLE_STUDENT, ROLE_TEACHER] }

end
