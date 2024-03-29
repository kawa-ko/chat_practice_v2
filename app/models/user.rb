class User < ApplicationRecord
    attr_accessor :remember_token, :activation_token
    before_save { self.email.downcase! }
    before_create :create_activation_digest
    validates :name, presence: true, length: { maximum: 50 }
    validates :email, presence: true, length: { maximum: 255 },
                      format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                      uniqueness: { case_sensitive: false }
    has_secure_password

    has_many :messages, dependent: :destroy

    has_many :created_rooms, class_name: 'Room', foreign_key: 'host_id', dependent: :destroy

    has_many :participations, dependent: :destroy
    has_many :participating_rooms, through: :participations, source: :room
    
    mount_uploader :image, ImageUploader

    def User.digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                      BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end

    def User.new_token
      SecureRandom.urlsafe_base64
    end

    def remember
      self.remember_token = User.new_token
      update_attribute(:remember_digest, User.digest(remember_token))
    end

    def authenticated?(attribute, token)
      digest = send("#{attribute}_digest")
      BCrypt::Password.new(digest).is_password?(token)
    end

    def forget
        update_attribute(:remember_digest, nil)
    end

    private
      def create_activation_digest
        self.activation_token = User.new_token  
        self.activation_digest = User.digest(activation_token)    
      end
end
