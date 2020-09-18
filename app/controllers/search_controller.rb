class SearchController < ApplicationController
  def search
    @keyword = params[:search]
    if params[:search].present?
      @rooms = Room.where('name LIKE ?', "%#{params[:search]}%").page(params[:page]).per(16)
    else
      @users = User.none
      @rooms = Room.none
    end
  end

  def room_search
    @rooms = Room.where('name LIKE ?', "%#{params[:format]}%").page
  end

  def user_search
    @users = User.where('name LIKE ?', "%#{params[:format]}%")
  end
end
