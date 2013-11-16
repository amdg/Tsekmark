require File.expand_path('../boot', __FILE__)

require 'rails/all'
require 'active_support/core_ext/numeric/bytes'

#if defined?(Bundler)
#  # If you precompile assets before deploying to production, use this line
#  Bundler.require(*Rails.groups(:assets => %w(development test)))
#  # If you want your assets lazily compiled in production, use this line
#  # Bundler.require(:default, :assets, Rails.env)
#end

if defined?(Bundler)
  Bundler.require(*Rails.groups(:assets => %w(development test), :profiling => %w[staging development]))
end

module Tsekmark
  class Application < Rails::Application

    # don't generate RSpec tests for views and helpers
    config.generators do |g|
      
      g.test_framework :rspec, fixture: true
      g.fixture_replacement :factory_girl, dir: 'spec/factories'

      g.orm :active_record
      g.view_specs false
      g.helper_specs false
    end

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Custom directories with classes and modules you want to be autoloadable.
    # config.autoload_paths += %W(#{config.root}/extras)
    config.autoload_paths += %W(#{config.root}/lib)
    config.autoload_paths += Dir["#{config.root}/lib/**/"]

    # Only load the plugins named here, in the order given (default is alphabetical).
    # :all can be used as a placeholder for all plugins not explicitly named.
    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

    # Activate observers that should always be running.
    # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password, :password_confirmation]

    # Enable escaping HTML in JSON.
    config.active_support.escape_html_entities_in_json = true

    # Use SQL instead of Active Record's schema dumper when creating the database.
    # This is necessary if your schema can't be completely dumped by the schema dumper,
    # like if you have constraints or database-specific column types
    # config.active_record.schema_format = :sql

    # Enforce whitelist mode for mass assignment.
    # This will create an empty whitelist of attributes available for mass-assignment for all models
    # in your app. As such, your models will need to explicitly whitelist or blacklist accessible
    # parameters by using an attr_accessible or attr_protected declaration.
    config.active_record.whitelist_attributes = true

    # Enable the asset pipeline
    config.assets.enabled = true

    # Version of your assets, change this if you want to expire all your assets
    config.assets.version = '1.0'

    config.quiet_assets = true

    # FB
    facebook_creds = YAML.load_file(Rails.root + 'config/facebook.yml')[Rails.env].symbolize_keys
    config.fb_app_id = facebook_creds[:app_id]
    config.fb_app_secret = facebook_creds[:app_secret]

    # Google
    google_creds = YAML.load_file(Rails.root + 'config/google.yml')[Rails.env].symbolize_keys
    config.google_app_id = google_creds[:app_id]
    config.google_app_secret = google_creds[:app_secret]

    # Assets
    config.asset_url = Rails.root + 'app/assets'

    # Domains and Ports
    domains_and_ports = YAML::load(ERB.new(IO.read(File.open(Rails.root.join("config/domains_and_ports.yml")))).result)[Rails.env].symbolize_keys
    http_port =  domains_and_ports[:http].blank? ? nil : domains_and_ports[:http]
    config.default_host = [domains_and_ports[:default_host], http_port].compact.join(":")

    es_config = YAML.load_file("#{Rails.root}/config/elasticsearch.yml")[Rails.env] if File.exist?("#{Rails.root}/config/elasticsearch.yml")
    config.es_host = es_config['host']

    # Paperclip
    Paperclip::Railtie.insert
    # Paperclip.options[:command_path] = `which identify`.sub(/\/identify/, '').strip
    s3_config = YAML.load_file("#{Rails.root}/config/s3.yml")[Rails.env] if File.exist?("#{Rails.root}/config/s3.yml")
    s3_bucket = s3_config ? s3_config.delete('bucket') : nil
    config.paperclip_storage = :filesystem
    config.paperclip_photo_path = 'public/system/:class/:attachment/:id/:style_:timestamp:extension'
    config.paperclip_resume_path = 'public/system/:class/:attachment/:id/:style_:timestamp:extension'
    config.paperclip_protocol = 'http'
    config.paperclip_url = ':dev_test_url'
    config.paperclip_fog_host = "http://s3.amazonaws.com/#{s3_bucket}"
    config.paperclip_fog_private_host = ''
    config.paperclip_fog_directory = s3_bucket
    config.paperclip_fog_credentials = s3_config ? s3_config.symbolize_keys.except(:id) : nil
    config.paperclip_fog_public = true
    config.paperclip_fog_file = { :expires => 1.year.from_now.httpdate, :cache_control => "max-age=#{1.year.seconds.to_i}" }
    config.paperclip_default_asset_missing_url = "/images/:style/missing.png"
    config.paperclip_default_asset_no_image_url = "/images/missing.png"
    config.paperclip_allowed_image_content_types = %w{image/jpg image/jpeg image/pjpeg image/png image/x-png image/gif}
    config.paperclip_allowed_doc_content_types = %w{application/pdf application/msword application/vnd.openxmlformats-officedocument.wordprocessingml.document text/plain}
    config.paperclip_max_size = 20.megabytes
  end
end
