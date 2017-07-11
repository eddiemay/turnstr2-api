class Photo < ApplicationRecord
	belongs_to :album

	has_many :comments, as: :commentable
	
	# Paperclip configuration for adding image to User
  has_attached_file :image, styles: { thumb: "300x300>"}, default_url: "http://#{Rails.application.secrets.host}/images/missing.png"                    
 	validates_attachment_presence :image
	validates_attachment_size :image, :less_than => 5.megabytes
	validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/png']

	before_create :set_captured_date

	scope :grouped, -> {select("concat(year(captured_date), month(captured_date)) as month_group").group("concat(year(captured_date), month(captured_date))")}

	def set_captured_date
		self.captured_date = Date.today unless self.captured_date
	end
		
end
