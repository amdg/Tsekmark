require "omnicontacts"

Rails.application.middleware.use OmniContacts::Builder do
  importer :gmail, Rails.application.config.google_app_id, Rails.application.config.google_app_secret, {:redirect_path => "/contacts/gmail/callback"}
  importer :yahoo, Rails.application.config.yahoo_app_id, Rails.application.config.yahoo_app_secret, {:callback_path => '/contacts/yahoo/callback'}
  importer :hotmail, Rails.application.config.hotmail_app_id, Rails.application.config.hotmail_app_secret, {:redirect_path => "/contacts/hotmail/callback"}
end
