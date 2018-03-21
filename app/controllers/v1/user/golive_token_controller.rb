class V1::User::GoliveTokenController < V1::User::BaseController



  # POST /user/session
  def create

    begin
      token = current_user.tokbox_token_for_go_live(params[:session_id])
      render_success data: {token: token}, message: 'Token generated'
    rescue Exception => e  
     render_unprocessable_entity message: e.message
    end
  end



 end
