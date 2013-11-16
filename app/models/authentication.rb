class Authentication < ActiveRecord::Base
  attr_accessible :blaster, :token, :provider, :secret, :uid, :twitter_uid, :blaster_type, :blaster_id
  belongs_to :blaster, :polymorphic => true

  def self.create_with_oauth(oauth, user, context)
    authentication = Authentication.find_by_uid_and_provider(oauth.uid, oauth.provider)
    unless authentication
      blaster = context === 'biz' ? user.business : user
      blaster.authentications.create!(
        provider: oauth.provider,
        token: oauth.credentials.token,
        secret: oauth.credentials.secret,
        uid: oauth.uid
      )
    end
  end


end
