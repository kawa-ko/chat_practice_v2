class Message < ApplicationRecord
    validates :content, presence: true, length: { maximum: 500 }

    mount_uploader :image, ImageUploader

    belongs_to :user
    belongs_to :room
    
    def template
        ApplicationController.renderer.render partial: 'messages/message', locals: { message: self }
    end
end
