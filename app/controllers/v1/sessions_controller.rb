class V1::SessionsController < V1::BaseController

  # Filters
  skip_before_action :validate_user, except: [:destroy, :show]

  def show
    render json: current_user
  end

  # POST /v1/sessions
  def create
    # Check required params
    check_required_params params, [:login, :password]

    if @current_user = ::User.login(params[:login], params[:password])
      render_success message: I18n.t('session.login'), data: { auth_token: @current_user.auth_token, user: UserSerializer.new(@current_user) }
    else
      render_unauthorized message: I18n.t('session.invalid_creds')
    end
  end


  def destroy
    begin
      @current_user.devices.find_by(session_id: request.headers['HTTP_AUTH_TOKEN'])&.destroy
      render_success message: "Logout Successfully", data: {}

    rescue
      render_unprocessable_entity message: "Failed to delete device"
    end
  end




end
