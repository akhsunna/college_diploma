class GroupSubject < ActiveRecord::Base
  belongs_to :subject
  belongs_to :groups
end
