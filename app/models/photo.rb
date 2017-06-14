class Photo < ApplicationRecord
	belongs_to :user

	# Paperclip configuration for adding image to User
  has_attached_file :image, styles: { thumb: "300x300>"}, default_url: "http://#{Rails.application.secrets.host}/images/missing.png"                    
 	validates_attachment_presence :image
	validates_attachment_size :image, :less_than => 5.megabytes
	validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/png']

	before_create :set_captured_date

	def set_captured_date
		self.captured_date = Date.today unless self.captured_date
	end
		
end
