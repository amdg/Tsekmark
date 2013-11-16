PAPERCLIP_DEFAULT_ASSET_MISSING_URL = Rails.application.config.paperclip_default_asset_missing_url
PAPERCLIP_ALLOWED_IMAGE_CONTENT_TYPES = Rails.application.config.paperclip_allowed_image_content_types
PAPERCLIP_ALLOWED_DOC_CONTENT_TYPES = Rails.application.config.paperclip_allowed_doc_content_types
PAPERCLIP_MAX_SIZE = Rails.application.config.paperclip_max_size

PAPERCLIP_DEFAULT_IMAGE_OPTIONS = {
  :storage => Rails.application.config.paperclip_storage,
  :fog_directory => Rails.application.config.paperclip_fog_directory,
  :fog_credentials => Rails.application.config.paperclip_fog_credentials,
  :fog_public => Rails.application.config.paperclip_fog_public,
  :fog_protocol => Rails.application.config.paperclip_protocol,
  :fog_host => Rails.application.config.paperclip_fog_host,
  :fog_file => Rails.application.config.paperclip_fog_file,
  :path => Rails.application.config.paperclip_photo_path,
  :url => Rails.application.config.paperclip_url,
  :default_url => Rails.application.config.paperclip_default_asset_missing_url,
  :use_timestamp => false,
  :whiny => false
}
ap PAPERCLIP_DEFAULT_IMAGE_OPTIONS
PAPERCLIP_DEFAULT_DOC_OPTIONS = {
  :storage => Rails.application.config.paperclip_storage,
  :fog_directory => Rails.application.config.paperclip_fog_directory,
  :fog_credentials => Rails.application.config.paperclip_fog_credentials,
  :fog_public => Rails.application.config.paperclip_fog_public,
  :fog_protocol => Rails.application.config.paperclip_protocol,
  :fog_host => Rails.application.config.paperclip_fog_host,
  :fog_file => Rails.application.config.paperclip_fog_file,
  :path => Rails.application.config.paperclip_resume_path,
  :url => Rails.application.config.paperclip_url,
  :default_url => Rails.application.config.paperclip_default_asset_missing_url,
  :use_timestamp => false,
  :whiny => false
}

Paperclip.interpolates(:timestamp) do |attachment, style|
  attachment.instance_read(:updated_at).to_i
end

Paperclip.interpolates(:dev_test_url) do |attachment, style|
  protocol = Rails.application.config.paperclip_protocol
  hostname = protocol == 'https' ? Rails.application.config.ssl_host : Rails.application.config.default_host
  ap "-----------------------------------------------------------"
  ap hostname
  ap "-----------------------------------------------------------"
  "#{protocol}://#{hostname}/#{attachment.path(style).gsub(%r{^/}, "")}".gsub('public/', '')
end

Paperclip.interpolates(:extension) do |attachment, style_name|
  extension = ((style = attachment.styles[style_name]) && style[:format])
  if extension
    ".#{extension}"
  else
    ''
  end
end