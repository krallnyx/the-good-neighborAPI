class User < ApplicationRecord
	has_secure_password
	before_save :email_downcase
    has_many :requests, dependent: :destroy
    has_one_attached :image

	validates :email, presence: true , uniqueness: { case_sensitive: false }
	validates :email, format: { with: /\S+@\S+\.\S+/ }
	validates :password, :first_name, :last_name, presence: true
    validates :image,  presence: true, blob: { content_type: ['image/png', 'image/jpg', 'image/jpeg', 'application/pdf'], size_range: 1..3.megabytes }

	def email_downcase
		self.email = self.email.delete(' ').downcase
	end
	
end