class V1::User::DevicesController < V1::User::BaseController
  before_action :set_device, only: [:show, :destroy]

  # GET /user/devices
  def index
    render_success data: {
        devices: ActiveModel::Serializer::CollectionSerializer.new(current_user.devices, serializer: DeviceSerializer)
    }

  end


  # POST /user/devices
  def create
    @device = current_user.devices.find_or_initialize_by(device_udid: device_params[:device_udid], user_id: current_user.id)
    @device.assign_attributes(device_params)
    @device.session_id = request.headers['HTTP_AUTH_TOKEN']

    if @device.save
      render_success data: {device: DeviceSerializer.new(@device)}, message: I18n.t('resource.crated', resource: UserDevice.model_name.human)
    else
      render_unprocessable_entity message: @device.errors.full_messages.join(', ')
    end
  end



  # DELETE /user/devices/1
  def destroy
    if @device.destroy
      render_success data: {device: DeviceSerializer.new(@photo)}, message: I18n.t('resource.deleted', resource: UserDevice.model_name.human)
    else
      render_unprocessable_entity message: @device.errors.full_messages.join(', ')
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_device
      @device = current_user.devices.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def device_params
      params.fetch(:device, {}).permit(:device_udid, :device_push_token, :device_name, :device_ios, :voip_token)
    end
end
