class Story < ApplicationRecord
  
  belongs_to :user
 # Paperclip configuration for adding image to User
  has_attached_file :face1_video_thumb, styles: { thumb: "300x300>"}, default_url: "http://#{Rails.application.secrets.host}/images/missing.png"
  has_attached_file :face2_video_thumb, styles: { thumb: "300x300>"}, default_url: "http://#{Rails.application.secrets.host}/images/missing.png"
  has_attached_file :face3_video_thumb, styles: { thumb: "300x300>"}, default_url: "http://#{Rails.application.secrets.host}/images/missing.png"
  has_attached_file :face4_video_thumb, styles: { thumb: "300x300>"}, default_url: "http://#{Rails.application.secrets.host}/images/missing.png"
  has_attached_file :face1_media, styles: { thumb: "300x300>"}, default_url: "http://#{Rails.application.secrets.host}/images/missing.png"
  has_attached_file :face2_media, styles: { thumb: "300x300>"}, default_url: "http://#{Rails.application.secrets.host}/images/missing.png"
  has_attached_file :face3_media, styles: { thumb: "300x300>"}, default_url: "http://#{Rails.application.secrets.host}/images/missing.png"
  has_attached_file :face4_media, styles: { thumb: "300x300>"}, default_url: "http://#{Rails.application.secrets.host}/images/missing.png"

  validates :face1_media, :face2_media, :face3_media, :face4_media, attachment_presence: true
  validates_attachment_content_type :face1_media, :face2_media, :face3_media, :face4_media, content_type: ['image/jpeg', 'image/png', 'video/mp4']
  validates_attachment_content_type :face1_video_thumb, :face2_video_thumb, :face3_video_thumb, :face4_video_thumb, content_type: ['image/jpeg', 'image/png']

  before_face1_media_post_process :is_image_face1_media?
  before_face2_media_post_process :is_image_face2_media?
  before_face3_media_post_process :is_image_face3_media?
  before_face4_media_post_process :is_image_face4_media?

  
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


  def is_image?(attachment)
    ["image/jpeg", "image/pjpeg", "image/png", "image/x-png", "image/gif"].include?(attachment.content_type) 
  end

end
