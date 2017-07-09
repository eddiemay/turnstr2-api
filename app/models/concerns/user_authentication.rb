require 'jwt_auth_token'

module UserAuthentication
  extend ActiveSupport::Concern

  #--------- Start Class Inclusions ----------#

  included do

    # For authentication with password
    has_secure_password validations: false

  end

  # --------- Class Methods Written Here ------------- #
  module ClassMethods

    # Login user using username/email and password
    def login username_or_email, password
      user = User.find_by("email = ?", username_or_email )
      user && user.authenticate(password) ? user : false
    end

  end
  # --------- End Class Methods          ------------- #


  # -------- Enstance Methods Written Here ----------- #

  def auth_token
    payload = { user_id: id }
    JwtAuthToken.generate_token(payload)
  end

  # Generate password reset token and mail it to user
  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save! validate: false

    # This will deliver the email in background using resque
    UserMailer.password_reset(self).deliver_later
  end

  # Generate random token for any column passed as an argument
  def generate_token column
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

  # Implement change password functionality
  def change_password current_password, new_password, new_password_confirmation
    if authenticate(current_password)
      update(password: new_password, password_confirmation: new_password_confirmation)
      # Find a way to force user to logout after change password e.g mark his tokens as expired
    else
      errors.add :base, I18n.t('password.current_invalid')
      false
    end
  end

  # -------- End Instance Methods           ----------- #


  #---------- End Class Inclusions -----------#

end
