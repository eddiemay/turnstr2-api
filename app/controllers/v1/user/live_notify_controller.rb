class V1::User::LiveNotifyController < V1::User::BaseController



  # POST /user/session
  def create

    if current_user.live_broadcast_notification(params[:tokbox_session_id])
      render_success data: {}, message: "Invited"
    else
      render_unprocessable_entity message: @current_user.errors.full_messages.join(', ')
    end
  end


end
