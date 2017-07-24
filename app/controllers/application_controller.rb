class ApplicationController < ActionController::API

  # Concerns/response_renderer
  include ResponseRenderer
  include ExceptionHandler
  include ActionController::MimeResponds
  include ActionController::ImplicitRender


  # Filters
  before_action :set_locale

  protected

  # This method to inform user if there were missing required parameters
  def check_required_params params, required_params
    missing_params = []
    required_params.each do |p|
      missing_params << p if params[p].blank?
    end

    raise CustomErrors::MissingParams.new(missing_params) if missing_params.any?
  end

  # This method will set the locale to the one passed in the querystring to 'locale' param
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

end
