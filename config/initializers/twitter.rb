Twitter.configure do |config|
  config.consumer_key = Rails.application.config.twitter_app_id
  config.consumer_secret = Rails.application.config.twitter_app_secret
end