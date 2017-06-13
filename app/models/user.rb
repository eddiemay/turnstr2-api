class User < ApplicationRecord
  include UserAuthentication
  include HasEmail

  # Paperclip configuration for adding image to User
  has_attached_file :avatar_face1, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "http://#{Rails.application.secrets.host}/images/missing.png"
  has_attached_file :avatar_face2, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "http://#{Rails.application.secrets.host}/images/missing.png"
  has_attached_file :avatar_face3, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "http://#{Rails.application.secrets.host}/images/missing.png"
  has_attached_file :avatar_face4, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "http://#{Rails.application.secrets.host}/images/missing.png"
  has_attached_file :avatar_face5, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "http://#{Rails.application.secrets.host}/images/missing.png"
  has_attached_file :avatar_face6, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "http://#{Rails.application.secrets.host}/images/missing.png"
                      
  validates_attachment_content_type :avatar_face1, :avatar_face2, :avatar_face3,:avatar_face4, :avatar_face5, :avatar_face6, content_type: /\Aimage\/.*\Z/

  
  validates :username, uniqueness: true, allow_nil: true
  validates :password, length: {:within => 8..20}, confirmation: true, presence: true, :if => lambda{ !password.nil? }

  def password_reset_expired?
    reset_password_sent_at < 2.hours.ago
  end

  def create_reset_digest
    update_attributes(reset_password_roken: User.new_token, reset_password_sent_at: Time.zone.now)
  end

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  # Sends password reset email.
  def send_password_reset_email
    #UserMailer.password_reset(self).deliver_now
  end

end
