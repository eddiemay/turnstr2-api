class V1::User::GoliveSessionController < V1::User::BaseController


  # GET /user/golive_session
  def show
    render_success data: {
      user: UserSerializer.new(current_user)
    }
  end

  # POST /user/golive_session
  def create

    if live_session = current_user.create_live_session('go_live')
      # invite (send push notification) to invitee users so they can join the go live
      current_user.invite_users_to_my_live_session(params[:invitees], 'go_live', live_session.session_id)

      render_success data: {session: live_session}, message: I18n.t('resource.crated', resource: LiveSession.model_name.human)
    else
      render_unprocessable_entity message: current_user.errors.full_messages.join(', ')
    end
  end

  # PUT /user/golive_session
  def update
    # invite (send push notification) to invitee users so they can join the go live
    current_user.invite_users_to_my_live_session(params[:invitees], 'go_live', params[:tokbox_session_id])
    render_success data: {session: params[:tokbox_session_id]}, message: I18n.t('resource.updated', resource: LiveSession.model_name.human)

  end

 end
