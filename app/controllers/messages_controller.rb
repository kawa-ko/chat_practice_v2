class MessagesController < ApplicationController
  before_action :require_user_logged_in?

  def create
    @message = current_user.messages.create!(message_params)

    ActionCable.server.broadcast "room_channel_#{@message.room_id}", message: @message.template
  end

  private

  def message_params
    params.require(:message).permit(:content, :image, :room_id)
  end

end
