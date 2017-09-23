Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports.
  config.consider_all_requests_local = true

  # Enable/disable caching. By default caching is disabled.
  if Rails.root.join('tmp/caching-dev.txt').exist?
    config.action_controller.perform_caching = true

    config.cache_store = :memory_store
    config.public_file_server.headers = {
      'Cache-Control' => 'public, max-age=172800'
    }
  else
    config.action_controller.perform_caching = false

    config.cache_store = :null_store
  end

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  config.action_mailer.perform_caching = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load


  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true

  # Use an evented file watcher to asynchronously detect changes in source code,
  # routes, locales, etc. This feature depends on the listen gem.
  config.file_watcher = ActiveSupport::EventedFileUpdateChecker

  config.paperclip_defaults = {
    storage: :s3,
    s3_region:    Rails.application.secrets.s3_region,
    s3_host_name: Rails.application.secrets.s3_host_name,
    s3_protocol: :https,
    s3_credentials: {
      bucket:            Rails.application.secrets.s3_bucket,
      access_key_id:     Rails.application.secrets.s3_access_key_id,
      secret_access_key: Rails.application.secrets.s3_secret_access_key
    }
  }

  config.default_family_user_ids = [1,2,3,5,94]

  # OpenTok credential
  config.open_tok_api_key = "45910392"
  config.open_tok_api_secret = "7038c92fa5af4c0458779ae41eeecf4913cbb195"



end
