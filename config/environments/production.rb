Myflix::Application.configure do

  config.cache_classes = true
  config.eager_load = true
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  config.serve_static_files = false

  config.assets.compress = true
  config.assets.js_compressor = :uglifier

  config.assets.compile = false

  config.assets.digest = true

  config.i18n.fallbacks = true
  config.action_mailer.raise_delivery_errors = true
  config.active_support.deprecation = :notify

  config.action_mailer.smtp_settings = {
    :port           => ENV['SENDINBLUE_SMTP_PORT'],
    :address        => ENV['SENDINBLUE_SMTP_SERVER'],
    :user_name      => ENV['SENDINBLUE_SMTP_LOGIN'],
    :password       => ENV['SENDINBLUE_SMTP_PASSWORD'],
    :domain         => 'myflix-reltre-staging.herokuapp.com/',
    :authentication => 'login',
    :enable_starttls_auto => true
  }
  config.action_mailer.delivery_method = :smtp
end
