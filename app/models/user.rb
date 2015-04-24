class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name, presence: true

  belongs_to :group
  belongs_to :role

  def student?
    return true if Role.find(role_id).name == 'student'
    false
  end

  def teacher?
    return true if Role.find(role_id).name == 'teacher'
    false
  end

  class << self
    def students
      User.where(role_id: Role.find(name: 'student').id)
    end

    def teachers
      User.where(role_id: Role.find(name: 'teacher').id)
    end
  end
end
