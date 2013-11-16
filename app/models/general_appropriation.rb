include Grape::Entity::DSL
class GeneralAppropriation < ActiveRecord::Base
  belongs_to :owner
  belongs_to :area
  has_many :votes

  attr_accessible :year, :code, :description, :budget_ps, :budget_mooe, :budget_co, :owner_id, :area_id, :new_appropriation

  entity :id, :year, :code, :description, :budget_ps, :budget_mooe, :budget_co, :owner_id, :area_id, :new_appropriation do
    expose :votes, :using => Vote::Entity
    expose :department, :using => Department::Entity
    expose :owner, :using => Owner::Entity
    expose :area, :using => Area::Entity
  end

  delegate :department, :to => :owner

  def upvotes
    votes.upvote
  end

  def downvotes
    votes.downvote
  end

  def vagues
    votes.vague
  end

  def mehs
    votes.meh
  end


end
