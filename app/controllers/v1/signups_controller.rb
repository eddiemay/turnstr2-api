class V1::SignupsController < V1::BaseController

  # Filters
  skip_before_action :validate_user


  # POST /v1/signup
  def create
    # Check required params
    check_required_params signup_params, [:email, :password]
    user = ::User.new signup_params
    if user.save
      @current_user = User.login(signup_params[:email], signup_params[:password])
      render_success message: I18n.t('user.created'), data: { auth_token: @current_user.auth_token, user: UserSerializer.new(@current_user) }
    else
      render_unprocessable_entity message: user.errors.full_messages.join(', ')
    end
  end

  def signup_params
    params.require(:signup).permit(:email, :password, :first_name, :last_name, :username)
  end


end
