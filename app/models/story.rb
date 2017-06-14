class Story < ApplicationRecord
  
  
 # Paperclip configuration for adding image to User
  has_attached_file :face1_thumb, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "http://#{Rails.application.secrets.host}/images/missing.png"
  has_attached_file :face2_thumb, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "http://#{Rails.application.secrets.host}/images/missing.png"
  has_attached_file :face3_thumb, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "http://#{Rails.application.secrets.host}/images/missing.png"
  has_attached_file :face4_thumb, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "http://#{Rails.application.secrets.host}/images/missing.png"
  has_attached_file :story_face1, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "http://#{Rails.application.secrets.host}/images/missing.png"
  has_attached_file :story_face2, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "http://#{Rails.application.secrets.host}/images/missing.png"
  has_attached_file :story_face3, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "http://#{Rails.application.secrets.host}/images/missing.png"
  has_attached_file :story_face4, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "http://#{Rails.application.secrets.host}/images/missing.png"

  validates_attachment_content_type :face1_thumb, :face2_thumb, :face3_thumb,:face4_thumb, :story_face1, :story_face2, :story_face3, :story_face4, content_type: /\Aimage\/.*\Z/

end
