class Business < ActiveRecord::Base
  #extend FriendlyId

  acts_as_messageable
  acts_as_followable
  acts_as_follower

  belongs_to :business_category
  belongs_to :user
  belongs_to :location

  has_many :blasts, :as => :blaster, :dependent => :destroy
  has_many :contacts, :as => :blaster, :dependent => :destroy
  has_many :comments, :as => :blaster, :dependent => :destroy
  #has_many :patronages
  #has_many :followers, :through => :patronages, :source => :user
  #has_many :inverse_patronages, :class_name => "Patronage", :foreign_key => "user_id"
  #has_many :followings, :through => :inverse_patronages, :source => :user # Followers

  has_many :authentications, :as => :blaster, :dependent => :destroy
  has_one :facebook_auth, :as => :blaster, :class_name => 'Authentication', conditions: "provider='facebook'"
  has_one :linkedin_auth, :as => :blaster, :class_name => 'Authentication', conditions: "provider='linkedin'"
  has_one :twitter_auth, :as => :blaster, :class_name => 'Authentication', conditions: "provider='twitter'"

  attr_accessible :name, :email, :phone, :fax, :address1, :address2, :website, :location, :business_category,
                  :latitude, :longitude, :postal_code, :description, :specialties, :brands, :product_services, :user,
                  :verified, :photo

  has_attached_file :photo, PAPERCLIP_DEFAULT_IMAGE_OPTIONS.merge({
    :styles => {
      :medium => "300x300>",
      :thumb => "100x100>"
    }
  })

  validates_attachment_content_type :photo, :content_type => PAPERCLIP_ALLOWED_IMAGE_CONTENT_TYPES, :message => :invalid_image

  scope :name_like, lambda { |term|
    where("businesses.name like ?", "%#{term}%")
  }

  #friendly_id :name, use: :slugged
  alias_attribute :full_name, :name

  def patronized_by?(user)
    followers.include?(user)
  end

  def facebook_client
    return nil unless facebook_auth
    Koala::Facebook::API.new facebook_auth.token
  end

  def linkedin_client
    return nil unless linkedin_auth
    LinkedinFactory::authorize_user self
  end

  def twitter_client
    return nil unless twitter_auth
    Twitter::Client.new(
        :oauth_token => twitter_auth.token,
        :oauth_token_secret => twitter_auth.secret
    )
  end

  def create_authentication(auth)
    authentications.create(
      provider: auth.provider,
      token: auth.credentials.token,
      secret: auth.credentials.secret,
      uid: auth.uid
    )
  end

  def mailboxer_email(object)
    #Check if an email should be sent for that object
    #if true
    #email
    #if false
    #return nil
    nil
  end

  def unread_messages_count
    mailbox.inbox(:unread => true).count(:id, :distinct => true)
  end
end
