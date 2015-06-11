class FavFile < ActiveRecord::Base
  belongs_to :sub_file
  belongs_to :user
end
