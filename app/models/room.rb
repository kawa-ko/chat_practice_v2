class Room < ApplicationRecord
    has_many :messages, dependent: :destroy

    has_many :participations, dependent: :destroy 
    has_many :participating_users, through: :participations, source: :user
    belongs_to :host, class_name: 'User'
    mount_uploader :image, ImageUploader
end
