class RoomsController < ApplicationController
  before_action :require_user_logged_in?, except: [:index]
  def index
    @rooms = Room.all.page(params[:page]).per(16)
  end

  def create_index
    @created_rooms = current_user.created_rooms.all.page(params[:page]).per(16)
  end

  def participating_index
    @participating_rooms = current_user.participating_rooms.all.page(params[:page]).per(16)
  end

  def show
    @room  = Room.find(params[:id])
    @participation = Participation.find_by(room_id: @room.id, user_id: current_user.id)
    @participating_users = @room.participating_users.all
    @messages = @room.messages.all
    @message = current_user.messages.new(room_id: @room.id)
  end

  def new
    @room = Room.new(host_id: current_user.id)
  end

  def create
    @room = Room.new(room_params)
    if @room.save
      @participation = current_user.participations.create(room_id: @room.id)
      redirect_to room_path(@room)
      flash[:success] = 'ルームを作成しました'
    else
      render :new
      flash[:false] = 'ルームの作成に失敗しました'
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
    if current_user.id != @room.host_id
      redirect_to room_path(@room)
    else
      if @room.update(room_params)
        redirect_to room_path(@room)
        flash[:success] = 'ルームを編集しました'
      else
        redirect_back(fallback_location: edit_room_path(@room))
        flash[:false] = 'ルームの編集に失敗しました'
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
      flash[:success] = 'ルームを削除しました'
    end
  end

  def join_confirm
    @room = Room.find(params[:id])
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
