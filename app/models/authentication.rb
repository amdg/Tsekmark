class Authentication < ActiveRecord::Base
  attr_accessible :token, :provider, :secret, :uid

  def self.create_with_oauth(oauth, user, context)
    authentication = Authentication.find_by_uid_and_provider(oauth.uid, oauth.provider)
  end
end
