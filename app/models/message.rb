class Message < ApplicationRecord
    validates :content, presence: true, length: { maximum: 500 }

    mount_uploader :image, ImageUploader

    belongs_to :user, dependent: :destroy
    belongs_to :room
    
    def user
        @user = User.find(self.user_id) 
    end

    def template
        ApplicationController.renderer.render partial: 'messages/message', locals: { message: self }
    end
end
