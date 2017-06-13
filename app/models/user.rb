class User < ApplicationRecord
  include UserAuthentication
  include HasEmail


  
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
