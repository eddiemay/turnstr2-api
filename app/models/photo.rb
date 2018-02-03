class Photo < ApplicationRecord
	extend Enumerize
	include CanBeLiked
	include CanBeCommented
	belongs_to :album
	delegate :user, to: :album

	enumerize :visibility, in: [:public, :protected, :private], default: :protected

	has_many :comments, as: :commentable
	has_many :likes, as: :likable
	
	# Paperclip configuration for adding image to User
  has_attached_file :image, styles: { thumb: "300x300>", medium: "1024x1024"}, default_url: "http://#{Rails.application.secrets.host}/images/missing.png"                    
 	validates_attachment_presence :image
	validates_attachment_size :image, :less_than => 5.megabytes
	validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/png']

	before_create :set_captured_date
	after_create :set_cover_image

	scope :grouped, -> {select("concat(year(captured_date), month(captured_date)) as month_group").group("concat(year(captured_date), month(captured_date))")}

	def set_captured_date
		self.captured_date = Date.today unless self.captured_date
	end

	def set_cover_image
		album.update_attribute(:cover_image_url, image.url(:thumb))
  end		

		
end
