class Contact < ActiveRecord::Base
  belongs_to :blaster, :polymorphic => true

  attr_accessible :blaster, :provider, :provider_uid, :name, :email
end
