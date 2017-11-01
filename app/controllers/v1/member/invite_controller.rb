class V1::Member::InviteController < V1::BaseController
  before_action :set_member


  # GET /comments/1
  def create
    if @member.devices.count > 0 && @member.devices[0].device_push_token.present?
      begin
        n = Rpush::Apns::Notification.new
        n.app = Rpush::Apns::App.find_by_name("ios_app")
        # n.device_token = @member.devices[0].device_push_token
        n.device_token = '1aad3c4933ea02146e65fbbf425aa0401f8218b6114fd6c11e8ffb34e96bac7b'
        n.alert = "This is just a test notification from Turnstr!"
        n.data = { foo: 'bar' }
        n.save!

        Rpush.push
        Rpush.apns_feedback
        render json: {success: true, data: { }}
      rescue ActiveRecord::RecordInvalid => ex
        render_unprocessable_entity message: ex.message
      end



    else
      render_unprocessable_entity message: 'Device token not found'
    end


  end

 

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_member
      @member = User.find(params[:member_id])
    end

end
