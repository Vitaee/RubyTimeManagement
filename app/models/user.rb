class User < ApplicationRecord
    has_many :time_records, dependent: :destroy
    before_save :downcase_email
    validates :email, format: {with: URI::MailTo::EMAIL_REGEXP}, presence: true, uniqueness: true
    validates :password, length: { minimum: 6 }
    has_secure_password
    
    scope :lower_username, -> (username) { where("lower(username) like ?", "%#{username}%")  }

    
    private
    
    def downcase_email
        self.email = email.downcase
    end

end
