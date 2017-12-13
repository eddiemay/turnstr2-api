class Story < ApplicationRecord
  include CanBeLiked
  include CanBeCommented
  default_scope { order(created_at: :desc) }
  
  belongs_to :user

  has_many :comments, as: :commentable
  has_many :likes, as: :likable
  
 # Paperclip configuration for adding image to User
  has_attached_file :face1_video_thumb, styles: { thumb: "300x300>"}
  has_attached_file :face2_video_thumb, styles: { thumb: "300x300>"}
  has_attached_file :face3_video_thumb, styles: { thumb: "300x300>"}
  has_attached_file :face4_video_thumb, styles: { thumb: "300x300>"}
  has_attached_file :face5_video_thumb, styles: { thumb: "300x300>"}
  has_attached_file :face6_video_thumb, styles: { thumb: "300x300>"}

  has_attached_file :face1_media, styles: { thumb: "300x300>"}
  has_attached_file :face2_media, styles: { thumb: "300x300>"}
  has_attached_file :face3_media, styles: { thumb: "300x300>"}
  has_attached_file :face4_media, styles: { thumb: "300x300>"}
  has_attached_file :face5_media, styles: { thumb: "300x300>"}
  has_attached_file :face6_media, styles: { thumb: "300x300>"}

  validates :face1_media, attachment_presence: true
  validates_attachment_content_type :face1_media, :face2_media, :face3_media, :face4_media, :face5_media, :face6_media, content_type: ['image/jpeg', 'image/png', 'video/mp4']
  validates_attachment_content_type :face1_video_thumb, :face2_video_thumb, :face3_video_thumb, :face4_video_thumb, :face5_video_thumb, :face6_video_thumb, content_type: ['image/jpeg', 'image/png']

  before_face1_media_post_process :is_image_face1_media?
  before_face2_media_post_process :is_image_face2_media?
  before_face3_media_post_process :is_image_face3_media?
  before_face4_media_post_process :is_image_face4_media?
  before_face5_media_post_process :is_image_face5_media?
  before_face6_media_post_process :is_image_face6_media?

  scope :search, ->(text){
    where( " stories.caption LIKE :search", { search: "%#{text.downcase}%"})
  }

  #validations
  
  def is_image_face1_media?
    is_image?(face1_media)
  end

  def is_image_face2_media?
    is_image?(face2_media)
  end

  def is_image_face3_media?
    is_image?(face3_media)
  end

  def is_image_face4_media?
    is_image?(face4_media)
  end

  def is_image_face5_media?
    is_image?(face5_media)
  end  

  def is_image_face6_media?
    is_image?(face6_media)
  end

  def is_image?(attachment)
    ["image/jpeg", "image/pjpeg", "image/png", "image/x-png", "image/gif"].include?(attachment.content_type) 
  end
    
end
