class V1::User::LiveSessionController < V1::User::BaseController


  # GET /user/sessions
  def show
    render_success data: {
      user: UserSerializer.new(current_user)
    }
  end

  # POST /user/live_session
  def create

    if live_session = current_user.create_live_session('video_call')
      # invite (send push notification) to invitee users so they can join the live session
      current_user.invite_users_to_my_live_session(params[:invitees], params[:call_type], live_session.session_id)

      render_success data: {session: live_session}, message: I18n.t('resource.crated', resource: LiveSession.model_name.human)
    else
      render_unprocessable_entity message: current_user.errors.full_messages.join(', ')
    end
  end

  # PUT /user/live_session
  def update
    # invite (send push notification) to invitee users so they can join the go live
    current_user.invite_users_to_my_live_session(params[:invitees], 'video_call', params[:tokbox_session_id])
    render_success data: {session: params[:tokbox_session_id]}, message: I18n.t('resource.updated', resource: LiveSession.model_name.human)

  end



  # DELETE /photos/1
  def destroy


  end

 end
