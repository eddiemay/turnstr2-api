class V1::Member::InviteController < V1::BaseController
  before_action :set_member


  # GET /comments/1
  def create
    if @member.devices.count > 0 && @member.devices[0].device_push_token.present?
      begin
        n = Rpush::Apns::Notification.new
        n.app = Rpush::Apns::App.find_by_name("ios_app")
        n.device_token = @member.devices[0].device_push_token
        n.alert = "hi mom!"
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
