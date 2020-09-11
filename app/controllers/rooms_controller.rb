class RoomsController < ApplicationController
  before_action :require_user_logged_in?, only: [:show]
  def index
    @rooms = Room.all
  end

  def show
    @room  = Room.find(params[:id])
    @messages = @room.messages.all
    @message = current_user.messages.new(room_id: @room.id)
  end

  def new
    @room = Room.new(host_id: current_user.id)
  end

  def create
    @room = Room.new(room_params)
    if @room.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    @room = Room.find(params[:id])
    if current_user.id != @room.host_id
      redirect_to room_path(@room)
    end
  end

  def update
    @room = Room.find(params[:id])
    room_host_check(@room)
    if current_user.id != @room.host_id
      redirect_to room_path(@room)
    else
      if @room.update(room_params)
        redirect_to room_path(@room)
      else
        redirect_back(fallback_location: edit_room_path(@room))
      end
    end
  end

  def destroy
    @room = Room.find(params[:id])
    if current_user.id != @room.host_id
      redirect_to room_path(@room)
    else
      @room.destroy
      redirect_to root_path
    end
  end

  private

  def room_params
    params.require(:room).permit(:name, :image, :remove_image, :host_id)
  end

  def room_host_check(room)
    if room.host_id == current_user.id
      redirect_to room_path(room)
      return
    end
  end
end
