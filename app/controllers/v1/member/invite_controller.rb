class V1::Member::InviteController < V1::BaseController
  before_action :set_member


  # GET /comments/1
  def create

    # ignore if device token not there
    if @member.devices[0]&.voip_token.blank?
      render_unprocessable_entity message: 'Device token not found'
      return
    end

    # ignore if device token not there
    #if current_user.live_session.blank?
      #render_unprocessable_entity message: 'Current user do not have tokbox session'
      #return
    #end


    begin
      n = Rpush::Apns::Notification.new
      n.app = Rpush::Apns::App.find_by_name("ios_app")
      n.device_token = @member.devices[0].voip_token
      n.alert = "Invitation from #{current_user.first_name} to join go live"
      n.data = {
          caller_first_name: current_user.first_name,
          caller_last_name: current_user.last_name,
          #caller_tokbox_session_id: current_user.live_session.session_id,
          caller_id: current_user.id,
          sender_id: @member.id
      }
      n.save!

      Rpush.push
      Rpush.apns_feedback

      render json: {success: true, data: { }}

    rescue ActiveRecord::RecordInvalid => ex
      render_unprocessable_entity message: ex.message
    end

  end

 

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_member
      @member = User.find(params[:member_id])
    end

end
