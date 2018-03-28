class V1::User::LiveSessionController < V1::User::BaseController


  # GET /user/sessions
  def show
    render_success data: {
      user: UserSerializer.new(current_user)
    }
  end

  # POST /user/session
  def create
      current_user.invite_users_to_my_live_session(params[:invitees], params[:call_type], params[:tokbox_session_id])
      render_success data: {session: live_session}, message: I18n.t('resource.crated', resource: LiveSession.model_name.human)

  end



  # DELETE /photos/1
  def destroy


  end

 end
