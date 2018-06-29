class PushNotifier

  def self.send(tokens, title, data)
    firebase_server_api_key = Rails.application.secrets.firebase_server_api_key
    HTTParty.post('https://fcm.googleapis.com/fcm/send',
                  :body => JSON.generate(
                      {
                          registration_ids: tokens,
                          priority: 'high',
                          notification: {title: '', body:title},
                          data: data
                      }
                  ),
                  :headers => {"Authorization" => "key=#{firebase_server_api_key}", "Content-Type" => "application/json"})

  end


  def self.queue_voip(voip_token, title, data)
      n = Rpush::Apns::Notification.new
      n.app = Rpush::Apns::App.find_by_name("ios_app")
      n.device_token = voip_token
      n.content_available = true
      n.alert = title
      n.data = data
      n.save!

  end


  def self.deliver_voip
    Rpush.push
    Rpush.apns_feedback
  end
end