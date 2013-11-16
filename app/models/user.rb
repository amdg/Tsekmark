include Grape::Entity::DSL
class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :token_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  acts_as_messageable
  acts_as_followable
  acts_as_follower

  has_many :blasts, :as => :blaster, :dependent => :destroy
  has_many :contacts, :as => :blaster, :dependent => :destroy
  has_many :comments, :as => :blaster, :dependent => :destroy
  has_many :authentications, :as => :blaster, :dependent => :destroy

  has_one :facebook_auth, :as => :blaster, :class_name => 'Authentication', conditions: "provider='facebook'"
  has_one :linkedin_auth, :as => :blaster, :class_name => 'Authentication', conditions: "provider='linkedin'"
  has_one :twitter_auth, :as => :blaster, :class_name => 'Authentication', conditions: "provider='twitter'"
  has_one :business, dependent: :destroy
  belongs_to :location
  attr_accessor :expose_token
  attr_accessible :role_ids, :as => :admin
  attr_accessible :email, :password, :password_confirmation, :remember_me, :provider, :twitter_uid,
                  :email, :first_name, :last_name, :linkedin_secret, :linkedin_token, :photo, :location

  has_attached_file :photo, PAPERCLIP_DEFAULT_IMAGE_OPTIONS.merge({
    :styles => {
      :medium => "300x300>",
      :thumb => "100x100>"
    }
  })

  validates_attachment_content_type :photo, :content_type => PAPERCLIP_ALLOWED_IMAGE_CONTENT_TYPES, :message => :invalid_image


  entity :id, :email, :full_name, :medium_photo, :thumb_photo, :date_of_birth, :first_name, :last_name do
    expose :authentication_token, :if => lambda { |object, options| object.expose_token === true }
  end


  alias_attribute :name, :first_name

  scope :name_like, lambda { |term|
    where("users.first_name like ?", "%#{term}%")
  }

  def self.find_for_linkedin_oauth(auth)
    Rails.logger.error auth.inspect
    user = User.find_by_email auth.info.email
    unless user
      user = User.new(first_name:auth.first_name,
                      email:auth.info.email,
                      last_name: auth.info.last_name,
                      #photo: auth.info.image,
                      password: nil
      )
      #user.skip_confirmation!
      #user.confirm!
      user.save(validate: false)
    end
    user.create_authentication(auth) if user.linkedin_auth.nil?
    user
  end

  def medium_photo
    photo.url(:medium)
  end

  def thumb_photo
    photo.url(:thumb)
  end

  def self.find_for_facebook_oauth(auth)
    Rails.logger.error auth.inspect
    user = User.find_by_email auth.info.email
    unless user
      user = User.new(first_name: auth.extra.raw_info.first_name,
                      last_name: auth.extra.raw_info.last_name,
                      email:auth.info.email,
                      password: nil,
                      photo: URI.parse(auth.info.image.gsub(/square/, 'large'))
      )
      #user.skip_confirmation!
      #user.confirm!
      user.save(validate: false)
    end
    user.create_authentication(auth) if user.facebook_auth.nil?
    user
  end

  def self.find_for_twitter_oauth(auth)
    user = User.find_by_twitter_uid auth.uid
    unless user
      user = User.new(first_name: auth.info.name,
                      twitter_uid: auth.uid,
                      email: auth.uid + '-twitter@tsekmark.com',
                      password: nil,
                      photo: URI.parse(auth.info.image)
      )
      #user.skip_confirmation!
      user.save(validate: false)
    end
    user.create_authentication(auth) if user.twitter_auth.nil?
    user
  end

  def create_authentication(auth)
    authentications.create(
        provider: auth.provider,
        token: auth.credentials.token,
        secret: auth.credentials.secret,
        uid: auth.uid
    )
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  alias_method :name, :full_name

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

  def user_ids_that_matter
    user_ids = neighbors.map(&:id) + self.followings.map(&:id) + [self.id]
    user_ids.uniq
  end

  def biz_ids_that_matter
    biz_ids = neighbor_businesses.map(&:id)
    biz_ids += [self.business.id] if has_business?
    biz_ids.uniq
  end

  def neighbors
    return [] unless self.location
    self.location.users.except(self)
  end

  def neighbor_businesses
    return [] unless self.location
    self.location.businesses
  end
  #
  #def following?(other_user)
  #
  #end
  #
  #def followed_by?(other_user)
  #  followers.include?(other_user)
  #end
  #
  #def friendship_with(other_user)
  #  friendships.find_by_friend_id other_user.id
  #end
  #
  #def patronage_with(biz)
  #  patronages.find_by_business_id biz.id
  #end

  def has_business?
    business.present?
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

