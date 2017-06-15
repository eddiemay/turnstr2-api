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

  validates_attachment_content_type :face1_media, :face2_media, :face3,_media :face4_media, content_type: ['image/jpeg', 'image/png', 'video/mp4']
  validates_attachment_content_type :face1_video_thumb, :face2_video_thumb, :face3_video_thumb, :face4_video_thumb, content_type: ['image/jpeg', 'image/png']

end
