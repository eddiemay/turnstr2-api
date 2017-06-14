class Story < ApplicationRecord
  
  
 # Paperclip configuration for adding image to User
  has_attached_file :story_face1_thumb_url, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "http://#{Rails.application.secrets.host}/images/missing.png"
  has_attached_file :story_face2_thumb_url, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "http://#{Rails.application.secrets.host}/images/missing.png"
  has_attached_file :story_face3_thumb_url, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "http://#{Rails.application.secrets.host}/images/missing.png"
  has_attached_file :story_face4_thumb_url, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "http://#{Rails.application.secrets.host}/images/missing.png"
  has_attached_file :story_face1_url, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "http://#{Rails.application.secrets.host}/images/missing.png"
  has_attached_file :story_face2_url, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "http://#{Rails.application.secrets.host}/images/missing.png"
  has_attached_file :story_face3_url, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "http://#{Rails.application.secrets.host}/images/missing.png"
  has_attached_file :story_face4_url, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "http://#{Rails.application.secrets.host}/images/missing.png"

  validates_attachment_content_type :story_face1_thumb_url, :story_face2_thumb_url, :story_face3_thumb_url,:story_face4_thumb_url, :story_face1_url, :story_face2_url, :story_face3_url, :story_face4_url, content_type: /\Aimage\/.*\Z/

end
