class DeviceSerializer < ActiveModel::Serializer
  attributes :id, :device_udid, :device_push_token, :device_name, :device_ios, :voip_token

end
