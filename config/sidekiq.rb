Sidekiq.configure_server do |config|
  config.redis = { url: 'redis://redistogo:454ab082d5659fd2272503b3d0dc9845@koi.redistogo.com:11185/' }
  config.redis = { size: 3 }
end

Sidekiq.configure_client do |config|
  config.redis = { url: 'redis://redistogo:454ab082d5659fd2272503b3d0dc9845@koi.redistogo.com:11185/' }
end
