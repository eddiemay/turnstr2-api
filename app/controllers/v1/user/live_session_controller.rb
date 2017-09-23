class V1::User::LiveSessionController < V1::User::BaseController


  # GET /user/sessions
  def show
    render_success data: {
      user: UserSerializer.new(current_user)
    }
  end

  # POST /user/session
  def create

    if current_user.create_live_session
      render_success data: {user: UserSerializer.new(current_user)}, message: I18n.t('resource.crated', resource: LiveSession.model_name.human)
    else
      render_unprocessable_entity message: @photo.errors.full_messages.join(', ')
    end
  end



  # DELETE /photos/1
  def destroy


  end

 end
