class RoomsController < ApplicationController
  def show
    @messages = Message.all
    @message = Message.new
  end
end
