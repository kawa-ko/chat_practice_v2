class ParticipationsController < ApplicationController
  def index
    @room = Room.find(params[:room_id])
    @participations = @room.participating_users.all
  end

  def create
    @participation = current_user.participations.new(room_id: params[:room_id])
    @participation.save
    redirect_to room_path(@participation.room_id)

    join_notice = ApplicationController.renderer.render partial: 'rooms/join_notice', locals: { user_name: current_user.name }
    ActionCable.server.broadcast "room_channel_#{@participation.room_id}", join_notice: join_notice
  end

  def destroy
    @participation = Participation.find(params[:id])
    @participation.destroy
    redirect_to root_path
  end
end
