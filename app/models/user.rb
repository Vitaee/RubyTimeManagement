class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  extend Devise::Models
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
    has_many :time_records, dependent: :destroy
    before_save :downcase_email
    validates :email, format: {with: URI::MailTo::EMAIL_REGEXP}, presence: true, uniqueness: true
    validates :password, length: { minimum: 6 }
    
    
    scope :lower_username, -> (username) { where("lower(username) like ?", "%#{username}%")  }

    
    private
    
    def downcase_email
        self.email = email.downcase
    end

end
