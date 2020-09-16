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
    exit_user = User.find_by(id: @participation.user_id)
    @participation.destroy
    redirect_to root_path
    exit_notice = ApplicationController.renderer.render partial: 'rooms/exit_notice', locals: { user_name: exit_user.name }
    ActionCable.server.broadcast "room_channel_#{@participation.room_id}", exit_notice: exit_notice
  end
end
