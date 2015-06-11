class InviteCode < ActiveRecord::Base
  belongs_to :group

  ROLE_TEACHER = 'teacher'
  ROLE_STUDENT = 'student'

  scope :teachers, ->{ where role: ROLE_TEACHER }
  scope :students, ->{ where role: ROLE_STUDENT }

  private

  def generate(role)

  end
end
