class V1::User::GoliveSessionController < V1::User::BaseController


  # GET /user/golive_session
  def show
    render_success data: {
      user: UserSerializer.new(current_user)
    }
  end

  # POST /user/session
  def create

    if current_user.create_live_session('go_live')
      current_user.reload
      # invite (send push notification) to invitee users so they can join the go live
      current_user.invite_users_to_my_live_session(params[:invitees], 'participant')

      render_success data: {session: current_user.live_session}, message: I18n.t('resource.crated', resource: LiveSession.model_name.human)
    else
      render_unprocessable_entity message: current_user.errors.full_messages.join(', ')
    end
  end



  # DELETE /photos/1
  def destroy


  end

 end
