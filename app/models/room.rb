class Room < ApplicationRecord
    has_many :messages, dependent: :destroy

    belongs_to :host, class_name: 'User'
    
    mount_uploader :image, ImageUploader
end
