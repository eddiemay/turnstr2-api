class RpushAppProduction < ActiveRecord::Migration[5.0]
  def up
    app = Rpush::Apns::App.new
    app.name = "ios_app"
    app.certificate = File.read(Rails.root.join('voipproduction.pem').to_s)
    app.environment = "development" # APNs environment.
    app.password = "secure@123"
    app.connections = 1
    app.save!
  end
end
