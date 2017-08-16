module ResponseRenderer

  ERRORS_LINK = "https://github.com/devzila/turnstr/wiki/error-listing"

  extend ActiveSupport::Concern

  included do ;  end

  module ClassMethods ;  end

  # Common method to render success response inside this module
  def render_succ success: true, message: nil, data: nil, status_code: 200
    render json: { success: success, message: message, data: data }, status: status_code
  end

  # Common method to render error response inside this module
  def render_error message: I18n.t('errors.e_400'), status_code: 200
    render json: { success: false, error: message, status_code: status_code, link: ERRORS_LINK }, status: status_code
  end

  # Handle Rails exceptions with custom JSON response
  def render_500_error message: I18n.t('errors.e_500')
    render_error message: message, status_code: 500
  end

  # Handle 400 errors with custom JSON response
  def render_bad_request message: I18n.t('errors.e_400')
    render_error message: message, status_code: 200
  end

  # Handle 422 errors with custom JSON response
  def render_unprocessable_entity message: nil
    render_error message: message, status_code: 222
  end

  # Handle 401 errors with custom JSON response
  def render_unauthorized message: nil
    render json: { success: false, error: message, status_code: 600, link: ERRORS_LINK }, status: 200
  end

  # Handle 404 errors with custom JSON response
  def render_not_found message: I18n.t('errors.e_404')
    render_error message: message, status_code: 404
  end

  # Handle 403 errors with custom JSON response
  def render_forbidden message: nil
    render_error message: message, status_code: 403
  end

  # Common method to render success response
  def render_success message: nil, data: nil
    render_succ success: true, message: message, data: data
  end

  # Common method to render empty response (no data available in db)
  def render_empty root: 'data', message: nil
    data = { count: 0, root.to_sym => []}
    render_succ success: true, message: message, data: data
  end

  # Common method to render create new resource
  def render_created message: nil, data: nil
    render_succ message: message, data: data, status_code: 201
  end

end
