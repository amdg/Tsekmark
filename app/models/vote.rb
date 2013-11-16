include Grape::Entity::DSL
class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :general_appropriation
  attr_accessible :comment, :vote_type, :user, :user_id, :general_appropriation, :general_appropriation_id

  has_attached_file :photo, PAPERCLIP_DEFAULT_IMAGE_OPTIONS.merge({
      :styles => {
          :medium => "300x300>",
          :thumb => "100x100>"
      }
  })

  TYPE_UPVOTE = 1
  TYPE_DOWNVOTE = 2
  TYPE_VAGUE = 3
  TYPE_MEH = 0

  entity :id, :comment, :vote_type, :medium_photo, :thumb_photo do
    expose :user, :using => User::Entity
    expose :general_appropriation, :using => GeneralAppropriation::Entity
  end

  scope :upvote, where(vote_type: TYPE_UPVOTE)
  scope :downvote, where(vote_type: TYPE_DOWNVOTE)
  scope :vague, where(vote_type: TYPE_VAGUE)
  scope :meh, where(vote_type: TYPE_MEH)

  def medium_photo
    photo.url(:medium)
  end

  def thumb_photo
    photo.url(:thumb)
  end

end
