class MessagesController < ApplicationController
  before_action :require_user_logged_in?

  def create
    @message = current_user.messages.create!(message_params)

    ActionCable.server.broadcast "room_channel_#{@message.room_id}", message: @message.template
  end

  def edit
    @message = Message.find(params[:id])
    if @message.user_id != current_user.id
      redirect_to room_path(@message.room_id)
    end
  end

  def update
    @message = Message.find(params[:id])
    if @message.update(message_params)
      redirect_to room_path(@message.room_id)
    end
  end

  def destroy
    @message = Message.find(params[:id])
    if @message.destroy
      redirect_to room_path(@message.room_id)
    end
  end

  private

  def message_params
    params.require(:message).permit(:content, :image, :room_id, :remove_image)
  end

end
