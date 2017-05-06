require 'jwt_auth_token'

module AuthenticateUser
  extend ActiveSupport::Concern

  included do
    # Check subdomain validity on every API call

    # Check for logged in user on every API call
    before_action :validate_user

  end


  # ======== Class Methods Written Here ========== #
  module ClassMethods ;  end
  # ======== End Class Methods ========== #


  # ======== Enstance Methods Written Here ========== #

  protected

  # This method is called before every Api action and sets the current_user and
  # current_company. If not authenticated or not valid user, it will throw error
  # with 401 status code.

  def validate_user
    token   = request.headers['HTTP_AUTH_TOKEN']
    token ||= params['auth_token']
    # head :unauthorized unless token.present? && JwtAuthToken.valid?(token)

    if token.present?
      # if api_token && api_token.user && api_token.user.organization_id == @current_organization.id
      if set_current_user(token) #&& @current_user.company_id == @current_company.id
        true
      else
        render_unauthorized message: I18n.t('base.not_authenticated')
      end
    else
      render_unauthorized message: I18n.t('base.login_required')
    end
  end

  # extract user_id from decoded_token and set current_user accordinally
  def set_current_user token
    if decoded_token = JwtAuthToken.valid?(token)
      @current_user = User.find_by id: decoded_token[0]['user_id']
    end
  end

  # ======== End Instance Methods ========== #

end
