class Story < ApplicationRecord
  
  belongs_to :user
 # Paperclip configuration for adding image to User
  has_attached_file :face1_video_thumb, styles: { thumb: "300x300>"}, default_url: "http://#{Rails.application.secrets.host}/images/missing.png"
  has_attached_file :face2_video_thumb, styles: { thumb: "300x300>"}, default_url: "http://#{Rails.application.secrets.host}/images/missing.png"
  has_attached_file :face3_video_thumb, styles: { thumb: "300x300>"}, default_url: "http://#{Rails.application.secrets.host}/images/missing.png"
  has_attached_file :face4_video_thumb, styles: { thumb: "300x300>"}, default_url: "http://#{Rails.application.secrets.host}/images/missing.png"
  has_attached_file :story_face1, styles: { thumb: "300x300>"}, default_url: "http://#{Rails.application.secrets.host}/images/missing.png"
  has_attached_file :story_face2, styles: { thumb: "300x300>"}, default_url: "http://#{Rails.application.secrets.host}/images/missing.png"
  has_attached_file :story_face3, styles: { thumb: "300x300>"}, default_url: "http://#{Rails.application.secrets.host}/images/missing.png"
  has_attached_file :story_face4, styles: { thumb: "300x300>"}, default_url: "http://#{Rails.application.secrets.host}/images/missing.png"

  validates_attachment_content_type :story_face1, :story_face2, :story_face3, :story_face4, content_type: ['image/jpeg', 'image/png', 'video/mp4']
  validates_attachment_content_type :face1_video_thumb, :face2_video_thumb, :face3_video_thumb, :face4_video_thumb, content_type: ['image/jpeg', 'image/png']

end
