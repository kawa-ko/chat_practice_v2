class MessagesController < ApplicationController
  before_action :require_user_logged_in?

  def create
    @message = current_user.messages.create!(message_params)

    ActionCable.server.broadcast "room_channel_#{@message.room_id}", message: @message.template
  end

  def edit
    @message = Message.find(params[:id])
    @user = @message.user
  end

  def update
    @message = Message.find(params[:id])
    if @message.update(message_params)
      redirect_to room_path(@message.room_id)
    end
  end

  def destroy_confirm
    @message = Message.find(params[:format])
  end

  def destroy_confirm
    @message = Message.find(params[:format])
  end

  def destroy
    @message = Message.find(params[:id])
    if @message.user == current_user
      @message.destroy
      redirect_to room_path(@message.room_id)
    else
      redirect_to room_path(@message.room_id)
    end
  end

  private

  def message_params
    params.require(:message).permit(:content, :image, :room_id, :remove_image)
  end

end
