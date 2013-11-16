class Blast < ActiveRecord::Base
  attr_accessible :user, :location, :body
  belongs_to :blaster, :polymorphic => true
  belongs_to :location

  default_scope order('created_at DESC')
  scope :from_users, lambda{ |user_ids| where(user_id: user_ids) }
  scope :in_same_location, lambda{ |location_id| where(location_id: location_id) }

  acts_as_commentable

  def blaster_location
    blaster.location
  end

  def self.from_followings_and_location(user_ids, biz_ids, location_id)
    blasts = Blast.arel_table
    Blast.where(
      blasts[:blaster_id].in(user_ids).and(blasts[:blaster_type].eq('User'))
      .or(blasts[:blaster_id].in(biz_ids).and(blasts[:blaster_type].eq('Business')))
      .or(blasts[:location_id].eq(location_id))
    )
  end
end
