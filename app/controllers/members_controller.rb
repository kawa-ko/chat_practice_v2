class MembersController < ApplicationController
    def index
    end

    def new
        @memeber = Mmeber.create(user_id: current_user.id, room_id: @room.id)
    end

    def create
    end

    def destroy
    end

end
