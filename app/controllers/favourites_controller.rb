class FavouritesController < ApplicationController

  def index
    if current_user.student?
      @fav_folders = current_user.folders
      @fav_files = current_user.sub_files
    end
  end

end
