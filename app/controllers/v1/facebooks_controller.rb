class V1::FacebooksController < V1::BaseController
 
  skip_before_action :validate_user

  # POST /facebooks
  def create
    # Check required params
    check_required_params params, [:user_id, :access_token]

    begin
      fb_user = FbGraph2::User.me(params[:access_token]).fetch(fields: [:name, :email, :first_name, :last_name])
      fb_user.fetch
    rescue FbGraph2::Exception::InvalidToken => ex
      render_error(message: ex.message) and return
    rescue Exception => ex
      render_error(message: ex.message) and return
    end 

    if fb_user.email.blank?
      render_error(message: "Unable to fetch user email by given access token") and return 
    end  


    # see if user alredy there in db 
    user = ::User.find_by(fb_user_id: params[:user_id])

    # try to find user by email if fb_user_id do not exists
    user = ::User.find_by(email: fb_user.email) unless user

    unless user
      # create user by fb details
      user = ::User.new({email: fb_user.email, first_name: fb_user.first_name, last_name: fb_user.last_name, fb_user_id: fb_user.id})

      unless user.save
        render_unprocessable_entity(message: user.errors.full_messages.join(', ') ) and return
      end  
    end

    # make user login
    @current_user = user
    render_success message: I18n.t('session.login'), data: { auth_token: @current_user.auth_token, user: UserSerializer.new(@current_user) }

  end

  private
    # Only allow a trusted parameter "white list" through.
    def facebook_params
      params.fetch(:facebook, {}).permit(:user_id, :access_token)
    end
end
