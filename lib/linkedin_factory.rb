class LinkedinFactory

  API_KEY = Rails.application.linkedin_app_key
  SECRET_KEY = Rails.application.linkedin_app_secret
  def self.authorize_user(user)
    token = user.linkedin_auth.token
    secret = user.linkedin_auth.secret

    client = LinkedIn::Client.new(API_KEY, SECRET_KEY)
    client.authorize_from_access(token, secret)
    client
  end

  def self.get_connections(user)
    client = self.authorize_user(user)
    ap client
    client.connections(:fields => ["id", "first-name", "last-name"])
  end

  def self.profile(user, fields={})
    client = self.authorize_user(user)
    client.profile(fields: fields)
  end

  def self.companies(user)
    client = self.authorize_user(user)
    profile = client.profile(:fields => %w(positions))
    profile.positions.map{|t| t.company.name }
  end
end